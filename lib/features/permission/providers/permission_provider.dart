import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/configs/storage_key.dart';
import 'package:verymemo/externals/storage/storage_service.dart';
import 'package:verymemo/features/permission/providers/state/permission_state.dart';
import 'package:verymemo/routers/navigation_service.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionNotifierProvider =
    StateNotifierProvider<PermissionNotifier, PermissionState>((ref) {
  final storageService = ref.watch(storageProvider);
  final navigationService = ref.watch(navigationServiceProvider);
  return PermissionNotifier(storageService, navigationService);
});

class PermissionNotifier extends StateNotifier<PermissionState> {
  final StorageService _storageService;
  final NavigationService _navigationService;

  PermissionNotifier(this._storageService, this._navigationService)
      : super(const PermissionState()) {
    loadStoredPermissions();
  }

  /// [약관 동의 (필수)] 토글 상태 업데이트
  void toggleAllAgree() {
    final isAgree = !state.allAgree;
    state = state.copyWith(allAgree: isAgree);

    if (isAgree) {
      // 모든 권한을 허용 상태로 업데이트
      _grantAllPermissions();
    } else {
      // 모든 권한을 거부 상태로 업데이트
      _denyAllPermissions();
    }
  }

  /// [모든 권한을 허용 상태로 설정]
  void _grantAllPermissions() {
    final updatedPermissions = {
      for (var type in PermissionType.values) type: true,
    };
    state = state.copyWith(
      permissions: updatedPermissions,
      allGranted: true,
    );
    savePermissions(updatedPermissions); // 저장
  }

  /// [모든 권한을 거부 상태로 설정]
  void _denyAllPermissions() {
    final updatedPermissions = {
      for (var type in PermissionType.values) type: false,
    };
    state = state.copyWith(
      permissions: updatedPermissions,
      allGranted: false,
    );
    savePermissions(updatedPermissions); // 저장
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
  }

  /// [특정 권한 상태 업데이트]
  void _updatePermission(PermissionType type, bool isGranted) {
    final isAllGranted = state.permissions.values.every((granted) => granted);
    state = state.copyWith(allGranted: isAllGranted);
    // if (isAllGranted) {
    //   _navigationService.go(AppRoute.login);
    // }
  }

  /// [모든 권한 허용 상태 업데이트]
  void _updateAllGrantedStatus() {
    final isAllGranted = state.permissions.values.every((granted) => granted);
    state = state.copyWith(allGranted: isAllGranted);

    // 로그인 페이지
    // _navigationService.go(AppRoute.signup);
    requestAllPermissions();
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

  Future<void> savePermissions(Map<PermissionType, bool> permissions) async {
    final encoded =
        jsonEncode(permissions.map((key, value) => MapEntry(key.name, value)));

    await _storageService.set(key: permissionsKey, data: encoded);
  }

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
  Future<void> loadStoredPermissions() async {
    final storedPermissions = await _loadPermissions();
    state = state.copyWith(
      permissions: storedPermissions,
      allGranted: storedPermissions.values.every((granted) => granted),
    );
    log("불러온 권한 상태: $storedPermissions");
  }
}
