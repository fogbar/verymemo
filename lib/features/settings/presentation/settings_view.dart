import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/list.dart';
import 'package:verymemo/common/barrel/button.dart';
import 'package:verymemo/features/settings/presentation/settings_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:verymemo/routers/router.dart';
import 'package:verymemo/common/ui/components/layout/variable_header.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsViewModelProvider);
    final settingsVM = ref.read(settingsViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: VariableHeader(
          type: HeaderType.content,
          onBack: () => context.go(AppRoute.home),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    onTap: () => settingsVM.onSyncTap(context),
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
                      toggleValue: settingsState.isDarkMode,
                      onToggleChanged: (value) =>
                          settingsVM.toggleDarkMode(value),
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
                    onTap: () => settingsVM.onDeletedMemosTap(context),
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
                    title: '회원 가입 / 가입 안된 유저는 가입 노출',
                    onTap: () => context.go(AppRoute.signup),
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
                    title: '회원 탈퇴 / 가입한 유저는 탈퇴 노출',
                    onTap: () => settingsVM.onWithdrawalTap(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
