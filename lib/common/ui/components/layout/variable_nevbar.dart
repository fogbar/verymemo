import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/common/ui/components/button/icon_btn.dart';

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

  const VariableNavigationBar({
    super.key,
    required this.type,
    required this.selectedIndex,
    this.onItemSelected,
    this.onFloatingButtonTap,
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

  /// ✅ 콘텐츠 네비게이션 바 (아이콘 4개, 터치해도 색상 변경 없음)
  List<Widget> _buildContentNav(BuildContext context) {
    return List.generate(
      NavigationBarConfig.contentIcons.length,
      (index) =>
          _navItem(NavigationBarConfig.contentIcons[index], index, context),
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
            ? Theme.of(context).colorScheme.primary // ✅ 홈 네비게이션만 선택 시 색상 변경
            : Theme.of(context).colorScheme.onSurface,
        onTap: () => onItemSelected?.call(index),
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
      onTap: () {
        debugPrint("Floating button tapped");
        if (onFloatingButtonTap != null) {
          onFloatingButtonTap!();
        }
      },
    );
  }
}
