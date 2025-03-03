import 'dart:developer';

import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/common/configs/storage_key.dart';
import 'package:verymemo/common/utils/json_util.dart';
import 'package:verymemo/common/utils/platform_util.dart';
import 'package:verymemo/externals/storage/storage_service.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:verymemo/features/auth/presentation/providers/user_provider.dart';
import 'package:verymemo/features/splash/state/splash_state.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewmodel, SplashState>((ref) {
  final storageService = ref.watch(storageProvider);
  final userNotifierProvider = ref.read(userProvider.notifier);
  return SplashViewmodel(storageService, userNotifierProvider);
});

class SplashViewmodel extends StateNotifier<SplashState> {
  final StorageService _storageService;
  final UserNotifier _userNotifier;
  SplashViewmodel(this._storageService, this._userNotifier)
      : super(const SplashState.loading()) {
    _init();
  }

  /// 1. DeviceId가 저장되어 있는지 체크
  ///  - O
  ///   - UserModel이 저장되어 있는지 체크
  ///     - O
  ///       - 회원 / 비회원 -> 저장된 UserModel을 메모리에 올림
  ///       - AppRoute.home 으로 보냄
  ///     - X : 최초는 X, 가입정보 입력 X
  ///       - AppRoute.auth로 보내버림
  ///
  ///   - X : 최초 접근인 경우
  ///    -> AppRoute.intro 로 보내버림

  // Init
  Future<void> _init() async {
    final deviceId = await PlatformUtil.getPlatformInfo();

    final user = await _storageService.get(key: userKey);
    await _storageService.remove(key: userKey);

    // 해당 deviceId가 로컬 DB에 저장되어 있는지 확인
    if (await containsValue(deviceId)) {
      // O
      // 유저모델 저장 여부
      // O
      if (user != null && user != "") {
        _userNotifier.saveUser(
          UserModel.fromJson(
            JsonUtil.stringToJson(
              user.toString(),
            ),
          ),
        );

        state = SplashState.home();
      } else {
        // X
        state = SplashState.signup();
      }
    } else {
      // X
      state = SplashState.intro();
    }
  }

  // Device Info 가져오기
  Future<bool> containsValue(String targetValue) async {
    final keys = await _storageService.getKeys();
    await _storageService.remove(key: userKey);

    for (String key in keys) {
      final value = await _storageService.get(key: key);
      if (value == targetValue) {
        log("---> targetValue: $targetValue");
        return true;
      }
    }
    return false;
  }
}
