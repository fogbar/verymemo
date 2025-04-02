import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/common/ui/components/button/icon_btn.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:verymemo/routers/router.dart';
import 'package:go_router/go_router.dart';

enum NavigationBarType { home, content }

class NavigationBarConfig {
  static const double minPadding = 32.0;
  static const double maxPadding = 80.0;
  static const double floatingButtonSize = 56.0;

  /// ✅ 홈 네비게이션 아이콘 (변경 없음, 색상만 변경)
  static const List<String> homeIcons = ["memo", "feed"];

  /// ✅ 콘텐츠 네비게이션 아이콘 (항상 동일)
  static const List<String> contentIcons = [
    "copy",
    "bookmark",
    "upload",
    "edit",
  ];
}

// ✅ 변수 네비게이션 바 위젯
class VariableNavigationBar extends StatelessWidget {
  final NavigationBarType type;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;
  final VoidCallback? onFloatingButtonTap;
  final WidgetRef ref;

  const VariableNavigationBar({
    super.key,
    required this.type,
    required this.selectedIndex,
    this.onItemSelected,
    this.onFloatingButtonTap,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth < 600
        ? NavigationBarConfig.minPadding
        : NavigationBarConfig.maxPadding;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      height: 72,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Expanded(child: _buildNavItems(context)), // ✅ 내부 아이콘 균등 배치
        ],
      ),
    );
  }

  /// ✅ 네비게이션 바 타입에 따라 아이콘 리스트 생성
  Widget _buildNavItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: type == NavigationBarType.home
          ? _buildHomeNav(context)
          : _buildContentNav(context),
    );
  }

  /// ✅ 홈 네비게이션 바 (아이콘 2개 + 중앙 플로팅 버튼)
  List<Widget> _buildHomeNav(BuildContext context) {
    return [
      _navItem("memo", 0, context),
      _floatingButton(context),
      _navItem("feed", 1, context),
    ];
  }

  /// ✅ 콘텐츠 네비게이션 바 (아이콘 4개)
  List<Widget> _buildContentNav(BuildContext context) {
    return [
      _contentNavItem("copy", context),
      _contentNavItem("bookmark", context),
      _contentNavItem("upload", context),
      _contentNavItem("edit", context),
    ];
  }

  /// ✅ 콘텐츠 네비게이션 아이콘 (터치해도 색상 변경 없음)
  Widget _contentNavItem(String iconKey, BuildContext context) {
    return Expanded(
      child: IconBtn(
        iconKey: iconKey,
        size: IconSize.large,
        color: Theme.of(context).colorScheme.onSurface,
        onTap: () async {
          try {
            if (Platform.isIOS || Platform.isAndroid) {
              await HapticFeedback.lightImpact();
            }
          } catch (e) {
            debugPrint('Haptic feedback failed: $e');
          }
          if (iconKey == "edit") {
            final memoState = ref.read(memoProvider);
            memoState.maybeWhen(
              successed: (memos) {
                final selectedMemo = ref.read(selectedMemoIdProvider);
                if (selectedMemo != null) {
                  final memo = memos
                      .firstWhere((m) => m.memoId.toString() == selectedMemo);
                  context.go('/edit', extra: memo);
                }
              },
              orElse: () {},
            );
          }
          onItemSelected
              ?.call(NavigationBarConfig.contentIcons.indexOf(iconKey));
        },
      ),
    );
  }

  /// ✅ 네비게이션 아이콘 (홈 네비게이션은 선택 시 색상 변경)
  Widget _navItem(String iconKey, int index, BuildContext context) {
    final bool isHomeNav = type == NavigationBarType.home;
    final bool isSelected = isHomeNav && selectedIndex == index;

    return Expanded(
      child: IconBtn(
        iconKey: iconKey,
        size: IconSize.large,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface,
        onTap: () async {
          try {
            if (Platform.isIOS || Platform.isAndroid) {
              await HapticFeedback.lightImpact();
            }
          } catch (e) {
            debugPrint('Haptic feedback failed: $e');
          }
          onItemSelected?.call(index);
        },
      ),
    );
  }

  /// ✅ 중앙 플로팅 버튼 (FAB)
  Widget _floatingButton(BuildContext context) {
    return IconCircleBtn(
      iconKey: "edit",
      state: ButtonState.black,
      circleSize: CircleButtonSize.medium,
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      onTap: () async {
        try {
          if (Platform.isIOS || Platform.isAndroid) {
            await HapticFeedback.mediumImpact();
          }
        } catch (e) {
          debugPrint('Haptic feedback failed: $e');
        }
        if (onFloatingButtonTap != null) {
          onFloatingButtonTap!();
        }
      },
    );
  }
}
