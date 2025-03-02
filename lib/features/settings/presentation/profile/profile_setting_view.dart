import 'package:verymemo/features/settings/presentation/profile/profile_setting_viewmodel.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/button.dart';

class ProfileSettingView extends ConsumerWidget {
  const ProfileSettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(profileSettingProvider.notifier);
    final state = ref.watch(profileSettingProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          const SizedBox(height: 120),
          // 프로필 이미지 섹션
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33120063),
                        blurRadius: 24,
                        offset: const Offset(11, 14),
                        spreadRadius: -24,
                      ),
                    ],
                  ),
                ),
              ),
              // 프로필 아바타
              GestureDetector(
                onTap: viewModel.updatePhoto,
                child: Avatar(
                  config: AvatarConfig(
                    avatarSize: 88,
                    imageUrl: state.photoUrl,
                    type: AvatarType.profile,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 64),
          // 이름 입력 필드
          SizedBox(
            width: 240,
            child: TextField(
              controller: viewModel.nameController,
              autofocus: true,
              textAlign: TextAlign.center,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                hintText: '닉네임',
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2.0,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(height: 64),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (MediaQuery.of(context).size.width * 0.1),
            ),
            child: RoundBtn(
              text: "이 프로필을 사용할게요",
              state: state.name.isNotEmpty
                  ? ButtonState.primary
                  : ButtonState.disabled,
              onPressed: state.name.isNotEmpty
                  ? () => viewModel.onStartButtonPressed()
                  : null,
              size: BoxSize.large,
              isExpanded: true,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }
}
