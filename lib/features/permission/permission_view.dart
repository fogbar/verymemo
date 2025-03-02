import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/common/title_subtitle.dart';
import 'package:verymemo/common/ui/components/button/round_btn.dart';
import 'package:verymemo/common/ui/components/list/list/list_item.dart';
import 'package:verymemo/common/ui/components/list/list/config_list_item.dart';
import 'package:verymemo/common/ui/common/config/config_box_style.dart';
import 'package:verymemo/features/permission/permission_viewmodel.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/features/permission/providers/permission_provider.dart';
import 'package:verymemo/features/permission/providers/state/permission_state.dart';

// final permissionProvider =
//     StateNotifierProvider<PermissionViewModel, PermissionState>((ref) {
//   return PermissionViewModel();
// });

class PermissionView extends ConsumerWidget {
  const PermissionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(permissionNotifierProvider.notifier);

    final viewModel = ref.watch(permissionProvider.notifier);
    // final state = ref.watch(permissionProvider);
    final state = ref.watch(permissionNotifierProvider);

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
                  checkboxValue: state.allAgree,
                  onCheckboxChanged: (value) => notifier.toggleAllAgree(),
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
                  checkboxValue:
                      state.permissions[PermissionType.camera] ?? false,
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
                  checkboxValue:
                      state.permissions[PermissionType.gallery] ?? false,
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
                  checkboxValue:
                      state.permissions[PermissionType.service] ?? false,
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
                  checkboxValue:
                      state.permissions[PermissionType.privacy] ?? false,
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
            state:
                state.allGranted ? ButtonState.primary : ButtonState.disabled,
            onPressed: state.allGranted
                ? () {
                    print('시작하기 버튼 클릭됨 (isAgreed: ${state.allAgree})');
                    // viewModel.onStartButtonPressed();
                    notifier.requestAllPermissions();
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
