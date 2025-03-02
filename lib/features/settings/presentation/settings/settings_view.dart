import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/list.dart';
import 'package:verymemo/common/barrel/button.dart';
import 'package:verymemo/features/settings/presentation/settings/settings_viewmodel.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsViewModelProvider);
    final settingsVM = ref.read(settingsViewModelProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        children: [
          ListItem(
            config: ListItemConfig(
                leadingType: ListItemType.icon,
                leadingIconKey: 'sync',
                leadingIconSize: IconSize.medium,
                leadingIconColor: Theme.of(context).colorScheme.primary,
                itemSpacing: 4),
            title: '동기화',
            onTap: () => settingsVM.onSyncTap(),
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
          ListItem(
            config: ListItemConfig(
              leadingType: ListItemType.icon,
              leadingIconKey: 'edit',
              leadingIconSize: IconSize.medium,
              leadingIconColor: Theme.of(context).colorScheme.primary,
              trailingType: ListItemType.toggle,
              toggleValue: settingsState.isKeypadEnabled,
              onToggleChanged: (value) => settingsVM.toggleKeypad(value),
            ),
            title: '진입시 키패드 모드',
            onTap: () =>
                settingsVM.toggleKeypad(!settingsState.isKeypadEnabled),
          ),
          ListItem(
            config: ListItemConfig(
              leadingType: ListItemType.icon,
              leadingIconKey: 'edit',
              leadingIconSize: IconSize.medium,
              leadingIconColor: Theme.of(context).colorScheme.primary,
              trailingType: ListItemType.toggle,
              toggleValue: settingsState.isDarkMode,
              onToggleChanged: (value) => settingsVM.toggleDarkMode(value),
            ),
            title: '다크 모드',
            onTap: () => settingsVM.toggleDarkMode(!settingsState.isDarkMode),
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
          ListItem(
            config: ListItemConfig(
              leadingType: ListItemType.icon,
              leadingIconKey: 'delete',
              leadingIconSize: IconSize.medium,
              leadingIconColor: Theme.of(context).colorScheme.primary,
            ),
            title: '최근 삭제한 메모',
            onTap: () => settingsVM.onDeletedMemosTap(),
          ),
          ListItem(
            config: ListItemConfig(
              leadingType: ListItemType.icon,
              leadingIconKey: 'star',
              leadingIconSize: IconSize.medium,
              leadingIconColor: Theme.of(context).colorScheme.primary,
            ),
            title: '앱 리뷰 남기기',
            onTap: () => settingsVM.onAppReviewTap(),
          ),
          ListItem(
            config: ListItemConfig(
              leadingType: ListItemType.icon,
              leadingIconKey: 'mic',
              leadingIconSize: IconSize.medium,
              leadingIconColor: Theme.of(context).colorScheme.primary,
            ),
            title: '오픈 카톡 커뮤니티',
            onTap: () => settingsVM.onOpenChatTap(),
          ),
          ListItem(
            config: ListItemConfig(
              leadingType: ListItemType.icon,
              leadingIconKey: 'phone',
              leadingIconSize: IconSize.medium,
              leadingIconColor: Theme.of(context).colorScheme.primary,
            ),
            title: '버전 정보',
            onTap: () => settingsVM.onVersionInfoTap(),
          ),
        ],
      ),
    );
  }
}
