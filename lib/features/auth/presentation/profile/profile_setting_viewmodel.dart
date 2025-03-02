import 'package:verymemo/common/barrel/model_common.dart';

final profileSettingProvider =
    StateNotifierProvider<ProfileSettingViewModel, ProfileSettingState>((ref) {
  return ProfileSettingViewModel();
});

class ProfileSettingState {
  final String name;
  final String? photoUrl;

  ProfileSettingState({
    this.name = '',
    this.photoUrl,
  });

  ProfileSettingState copyWith({
    String? name,
    String? photoUrl,
  }) {
    return ProfileSettingState(
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}

class ProfileSettingViewModel extends StateNotifier<ProfileSettingState> {
  final TextEditingController nameController = TextEditingController();

  ProfileSettingViewModel() : super(ProfileSettingState()) {
    _initializeUserData();
    nameController.text = state.name;
    _setupNameControllerListener();
  }

  void _setupNameControllerListener() {
    nameController.addListener(() {
      final newName = nameController.text;
      state = state.copyWith(name: newName);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _initializeUserData() {
    // TODO: 구글 로그인 정보 가져오기
    state = state.copyWith(
      name: "구글닉네임", //@사라 : 구글 로그인 정보를 디폴트로 뿌려줍니다!
      photoUrl: null,
    );
  }

  void updatePhoto() {
    // TODO: 사진 선택/업로드 로직 구현
    debugPrint('프로필 사진 업데이트');
  }

  void onStartButtonPressed() {
    if (state.name.isNotEmpty) {
      // TODO: 프로필 설정 완료 처리
      debugPrint('프로필 설정 완료 (name: ${state.name})');
    }
  }
}
