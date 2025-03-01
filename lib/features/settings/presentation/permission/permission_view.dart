import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/list.dart';
import 'package:verymemo/common/barrel/button.dart';
import 'package:verymemo/features/settings/presentation/permission/permission_viewmodel.dart';

final permissionProvider =
    StateNotifierProvider<PermissionViewModel, PermissionState>((ref) {
  return PermissionViewModel();
});

class PermissionView extends ConsumerWidget {
  const PermissionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(permissionProvider.notifier);
    final state = ref.watch(permissionProvider);

    return Column(
      children: [
        const SizedBox(height: 120),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width * 0.1),
          ),
          child: Column(
            children: [
              const TitleSubtitleWidget(
                title: '빠르게 쓰고\n쉽게 찾는 베리 메모',
                subtitle: '쾌적한 앱 사용을 위해 권한 허용을 해주세요',
                config: TitleSubtitlePresets.multiLine,
              ),
              const SizedBox(height: 40),
              ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.checkbox,
                  checkboxValue: state.isAgreed,
                  onCheckboxChanged: (value) => viewModel.checkAgreement('is'),
                ),
                title: '약관 동의 (필수)',
              ),
              Divider(
                height: 32,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 16),
              ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.icon,
                  leadingIconKey: 'camera',
                  itemSpacing: 22,
                ),
                title: '카메라 접근 권한 허용',
                subtitle: '메모 작성을 할 때 필요합니다',
              ),
              const SizedBox(height: 24),
              ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.icon,
                  leadingIconKey: 'gallery',
                  itemSpacing: 22,
                ),
                title: '사진 접근 권한 허용',
                subtitle: '메모 작성을 할 때 필요합니다',
              ),
              const SizedBox(height: 24),
              ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.icon,
                  leadingIconKey: 'user',
                  itemSpacing: 22,
                ),
                title: '서비스 이용 약관 동의   >',
                subtitle: '앱 이용을 위해 필요합니다',
                onTap: () {
                  print('서비스 이용 약관 클릭됨');
                  viewModel.onTermsPressed('service');
                },
              ),
              const SizedBox(height: 24),
              ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.icon,
                  leadingIconKey: 'user',
                  itemSpacing: 22,
                ),
                title: '개인정보 이용 약관 동의   >',
                subtitle: '개인정보 보호를 위해 필요합니다',
                onTap: () {
                  print('개인정보 약관 클릭됨');
                  viewModel.onTermsPressed('privacy');
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width * 0.1),
          ),
          child: RoundBtn(
            text: "권한 허용 동의 시작하기",
            state: state.isAgreed ? ButtonState.primary : ButtonState.disabled,
            onPressed: state.isAgreed
                ? () {
                    print('시작하기 버튼 클릭됨 (isAgreed: ${state.isAgreed})');
                    viewModel.onStartButtonPressed();
                  }
                : null,
            size: BoxSize.large,
            isExpanded: true,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
      ],
    );
  }
}
