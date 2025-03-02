import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:verymemo/features/auth/presentation/providers/state/user_state.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) => UserNotifier());

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
}
