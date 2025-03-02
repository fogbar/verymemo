import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/list.dart';
import 'package:verymemo/common/barrel/button.dart';
import 'package:verymemo/features/settings/presentation/settings_viewmodel.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsViewModelProvider);
    final settingsVM = ref.read(settingsViewModelProvider.notifier);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: ListItem(
                config: ListItemConfig(
                    leadingType: ListItemType.icon,
                    leadingIconKey: 'sync',
                    alignment: CrossAxisAlignment.center,
                    leadingIconSize: IconSize.medium,
                    leadingIconColor: Theme.of(context).colorScheme.primary,
                    itemSpacing: 12),
                title: '동기화',
                onTap: () => settingsVM.onSyncTap(),
              ),
            ),
            // ListItem(
            //   config: ListItemConfig(
            //     leadingType: ListItemType.icon,
            //     leadingIconKey: 'settings',
            //     leadingIconSize: IconSize.medium,
            //     leadingIconColor: Theme.of(context).colorScheme.primary,
            //   ),
            //   title: '태그 관리',
            //   onTap: () => debugPrint("태그 관리 클릭!"),
            // ),
            SizedBox(
              height: 56,
              child: ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.icon,
                  leadingIconKey: 'edit',
                  leadingIconSize: IconSize.medium,
                  leadingIconColor: Theme.of(context).colorScheme.primary,
                  trailingType: ListItemType.toggle,
                  itemSpacing: 12,
                  alignment: CrossAxisAlignment.center,
                  toggleValue: settingsState.isKeypadEnabled,
                  onToggleChanged: (value) => settingsVM.toggleKeypad(value),
                ),
                title: '진입시 키패드 모드',
                onTap: () =>
                    settingsVM.toggleKeypad(!settingsState.isKeypadEnabled),
              ),
            ),
            SizedBox(
              height: 56,
              child: ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.icon,
                  leadingIconKey: 'edit',
                  leadingIconSize: IconSize.medium,
                  leadingIconColor: Theme.of(context).colorScheme.primary,
                  trailingType: ListItemType.toggle,
                  itemSpacing: 12,
                  alignment: CrossAxisAlignment.center,
                  toggleValue: settingsState.isDarkMode,
                  onToggleChanged: (value) => settingsVM.toggleDarkMode(value),
                ),
                title: '다크 모드',
                onTap: () =>
                    settingsVM.toggleDarkMode(!settingsState.isDarkMode),
              ),
            ),
            // ListItem(
            //   config: ListItemConfig(
            //     leadingType: ListItemType.icon,
            //     leadingIconKey: 'settings',
            //     leadingIconSize: IconSize.medium,
            //     leadingIconColor: Theme.of(context).colorScheme.primary,
            //     trailingType: ListItemType.toggle,
            //   ),
            //   title: '키패드 제스쳐',
            //   onTap: () => debugPrint("키패드 제스쳐 클릭!"),
            // ),
            SizedBox(
              height: 56,
              child: ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.icon,
                  leadingIconKey: 'delete',
                  leadingIconSize: IconSize.medium,
                  itemSpacing: 12,
                  alignment: CrossAxisAlignment.center,
                  leadingIconColor: Theme.of(context).colorScheme.primary,
                ),
                title: '최근 삭제한 메모',
                onTap: () => settingsVM.onDeletedMemosTap(),
              ),
            ),
            // SizedBox(
            //   height: 56,
            //   child: ListItem(
            //     config: ListItemConfig(
            //       leadingType: ListItemType.icon,
            //       leadingIconKey: 'star',
            //       leadingIconSize: IconSize.medium,
            //       itemSpacing: 12,
            //       alignment: CrossAxisAlignment.center,
            //       leadingIconColor: Theme.of(context).colorScheme.primary,
            //     ),
            //     title: '앱 리뷰 남기기',
            //     onTap: () => settingsVM.onAppReviewTap(),
            //   ),
            // ),
            // SizedBox(
            //   height: 56,
            //   child: ListItem(
            //     config: ListItemConfig(
            //       leadingType: ListItemType.icon,
            //       leadingIconKey: 'mic',
            //       leadingIconSize: IconSize.medium,
            //       itemSpacing: 12,
            //       alignment: CrossAxisAlignment.center,
            //       leadingIconColor: Theme.of(context).colorScheme.primary,
            //     ),
            //     title: '오픈 카톡 커뮤니티',
            //     onTap: () => settingsVM.onOpenChatTap(),
            //   ),
            // ),
            SizedBox(
              height: 56,
              child: ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.icon,
                  leadingIconKey: 'phone',
                  leadingIconSize: IconSize.medium,
                  itemSpacing: 12,
                  alignment: CrossAxisAlignment.center,
                  leadingIconColor: Theme.of(context).colorScheme.primary,
                ),
                title: '버전 정보',
                onTap: () => settingsVM.onVersionInfoTap(),
              ),
            ),
            SizedBox(
              height: 56,
              child: ListItem(
                config: ListItemConfig(
                  leadingType: ListItemType.icon,
                  leadingIconKey: 'user',
                  leadingIconSize: IconSize.medium,
                  itemSpacing: 12,
                  alignment: CrossAxisAlignment.center,
                  leadingIconColor: Theme.of(context).colorScheme.primary,
                ),
                title: '회원 탈퇴',
                onTap: () => settingsVM.onWithdrawalTap(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
