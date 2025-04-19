import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:verymemo/features/auth/presentation/providers/state/user_state.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) => UserNotifier());

// 실제 사용하는 유저 정보.
// 유저 정보 참조시 userProvider 사용.
class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState());

  // 메모리에 유저모델 저장
  void saveUser(UserModel user) {
    state = UserState(user: user, isLoading: false);
  }

  // 사용자 정보 삭제
  void removeUser() {
    state = const UserState();
  }

  // 사용자 정보 가져오기
  UserModel? getUser() {
    return state.user;
  }

  // 구글 로그인 판단
  bool isGoogle() {
    return state.user?.authProvider == UserAuthProvider.google;
  }

  // 애플 로그인 판단
  bool isApple() {
    return state.user?.authProvider == UserAuthProvider.apple;
  }

  // 게스트 판단
  bool isGuest() {
    return state.user?.authProvider == UserAuthProvider.unknown;
  }
}
