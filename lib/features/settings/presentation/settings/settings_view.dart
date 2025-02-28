import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/button/icon_btn.dart';
import 'package:verymemo/common/ui/components/list/list/config_list_item.dart';
import 'package:verymemo/common/ui/components/list/list/list_item.dart';
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
            onTap: () => debugPrint("동기화 클릭!"),
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
            onTap: () => debugPrint("진입시 키패드 클릭!"),
          ),
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
            title: '다크 모드',
            onTap: () => debugPrint("다크모드 클릭!"),
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
            onTap: () => debugPrint("최근 삭제한 메모 클릭!"),
          ),
          ListItem(
            config: ListItemConfig(
              leadingType: ListItemType.icon,
              leadingIconKey: 'star',
              leadingIconSize: IconSize.medium,
              leadingIconColor: Theme.of(context).colorScheme.primary,
            ),
            title: '앱 리뷰 남기기',
            onTap: () => debugPrint("앱 리뷰 남기기 클릭!"),
          ),
          ListItem(
            config: ListItemConfig(
              leadingType: ListItemType.icon,
              leadingIconKey: 'mic',
              leadingIconSize: IconSize.medium,
              leadingIconColor: Theme.of(context).colorScheme.primary,
            ),
            title: '오픈 카톡 커뮤니티',
            onTap: () => debugPrint("오픈 카톡 커뮤니티 클릭!"),
          ),
          ListItem(
            config: ListItemConfig(
              leadingType: ListItemType.icon,
              leadingIconKey: 'phone',
              leadingIconSize: IconSize.medium,
              leadingIconColor: Theme.of(context).colorScheme.primary,
            ),
            title: '버전 정보',
            onTap: () => debugPrint("버전 정보 클릭!"),
          ),
        ],
      ),
    );
  }
}
