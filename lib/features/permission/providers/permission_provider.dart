import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/configs/storage_key.dart';
import 'package:verymemo/externals/storage/storage_service.dart';
import 'package:verymemo/features/permission/providers/state/permission_state.dart';
import 'package:verymemo/routers/navigation_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:verymemo/routers/router.dart';

enum PermissionType { camera, gallery, service, privacy }

final permissionNotifierProvider =
    StateNotifierProvider<PermissionNotifier, PermissionState>((ref) {
  final storageService = ref.watch(storageProvider);
  final navigationService = ref.watch(navigationServiceProvider);
  return PermissionNotifier(storageService, navigationService);
});

class PermissionState {
  final bool allAgree; // 필수 체크 토글 상태, 초기 값은 True
  final bool allGranted; // 모든 권한 허용 여부, 초기 값은 True
  final Map<PermissionType, bool> permissions;

  PermissionState({
    this.allAgree = true,
    this.allGranted = true,
    this.permissions = const {},
  });

  PermissionState copyWith({
    bool? allAgree,
    bool? allGranted,
    Map<PermissionType, bool>? permissions,
  }) {
    return PermissionState(
      allAgree: allAgree ?? this.allAgree,
      allGranted: allGranted ?? this.allGranted,
      permissions: permissions ?? this.permissions,
    );
  }
}

class PermissionNotifier extends StateNotifier<PermissionState> {
  final StorageService _storageService;
  final NavigationService _navigationService;

  PermissionNotifier(this._storageService, this._navigationService)
      : super(PermissionState());

  /// [약관 동의 (필수)] 토글 상태 업데이트
  void toggleAllAgree() {
    final isAgree = !state.allAgree;
    state = state.copyWith(allAgree: isAgree);

    final updatedPermissions = {
      for (var type in PermissionType.values) type: isAgree,
    };

    state = state.copyWith(
      permissions: updatedPermissions,
      allGranted: isAgree,
    );
  }

  /// [특정 권한 요청 및 업데이트]
  Future<void> requestPermission(PermissionType type) async {
    final permission = _mapToPermission(type);
    if (permission != null) {
      final status = await permission.request();
      _updatePermission(type, status.isGranted);
    } else {
      _updatePermission(type, true); // 약관 동의는 항상 허용
    }
  }

  /// [모든 권한 요청]
  Future<void> requestAllPermissions() async {
    for (var type in PermissionType.values) {
      await requestPermission(type);
    }
    _updateAllGrantedStatus();
    _savePermissions();
    _navigationService.pushAndRemoveUntil(AppRoute.signup);
  }

  /// [특정 권한 상태 업데이트]
  void _updatePermission(PermissionType type, bool isGranted) {
    final updatedPermissions = Map.of(state.permissions)..[type] = isGranted;
    state = state.copyWith(
      permissions: updatedPermissions,
      allGranted: updatedPermissions.values.every((granted) => granted),
    );
  }

  /// [모든 권한 허용 상태 업데이트]
  void _updateAllGrantedStatus() {
    state = state.copyWith(
      allGranted: state.permissions.values.every((granted) => granted),
    );
  }

  // Future<void> check

  /// [PermissionType을 Permission으로 매핑]
  Permission? _mapToPermission(PermissionType type) {
    switch (type) {
      case PermissionType.camera:
        return Permission.camera;
      case PermissionType.gallery:
        return Permission.photos;
      default:
        return null;
    }
  }

  Future<void> _savePermissions() async {
    // final encoded =
    //     jsonEncode(permissions.map((key, value) => MapEntry(key.name, value)));

    // 모든 약관에 동의를 해야 넘어갈 수 있으므로 state 로 처리. 이유는 _savePermissions 가
    // _updateAllGrantedStatus 이후에 불리기 때문
    final encoded = jsonEncode(
        state.permissions.map((key, value) => MapEntry(key.name, value)));

    await _storageService.set(key: permissionsKey, data: encoded);
  }

  /*
  Future<Map<PermissionType, bool>> _loadPermissions() async {
    final encoded = await _storageService.get(key: permissionsKey);

    if (encoded != null) {
      final decoded = Map<String, dynamic>.from(jsonDecode(encoded.toString()));
      return decoded.map((key, value) => MapEntry(
          PermissionType.values.firstWhere((e) => e.name == key),
          value as bool));
    }
    return {
      for (var type in PermissionType.values) type: false,
    }; // 기본값 false로 반환
  }

  /// [저장된 권한 불러오기]
  Future<void> _loadStoredPermissions() async {
    final storedPermissions = await _loadPermissions();
    state = state.copyWith(
      permissions: storedPermissions,
      allGranted: storedPermissions.values.every((granted) => granted),
    );
    log("불러온 권한 상태: $storedPermissions");
  }
  */

  /// [저장된 권한 불러오기 및 화면 전환 필요 여부 확인]
  /// 일단 퍼미션 체크는 처음에 key 값이 한 번 들어가면 굳이 다시 체크하지 않아도 되도록 처리 한다.
  /// 따라서 로직이 sharedPreferences의 key 값만 체크
  Future<bool> shouldNavigateToPermission() async {
    final encoded = await _storageService.get(key: permissionsKey);

    print("shouldNavigateToPermission - ${encoded}");

    return encoded == null;
  }

  // 해당 페이지로 이동 (일단 하나의 provider 에서 처리하도록 하고 향후 리펙토링 시 분리하던가 한다.)
  void onTermsPressed(String type) {
    switch (type) {
      case 'service':
        // 서비스 이용 약관 페이지로 이동
        print("서비스 이용 약관 페이지로 이동");
        break;
      case 'privacy':
        // 개인정보 처리방침 페이지로 이동
        print("개인정보 처리방침 페이지로 이동");
        break;
    }
  }
}
