import 'package:verymemo/features/auth/domain/models/user_model.dart';

class UserState {
  final UserModel? user;
  final bool isLoading;

  const UserState({
    this.user,
    this.isLoading = false,
  });
}
