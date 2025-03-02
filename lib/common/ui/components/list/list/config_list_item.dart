import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/common/title_subtitle.dart';
import 'package:verymemo/common/ui/components/button/icon_btn.dart';

enum ListItemType {
  image, // 이미지 (프로필, 썸네일 등)
  icon, // 아이콘 (액션 버튼 등)
  checkbox, // 체크박스
  toggle, // 토글
  text, // 텍스트 (카테고리, 숫자 등)
  none, // 아무것도 없음
}

class ListItemConfig {
  final EdgeInsets padding;
  final double itemSpacing;
  final ListItemType leadingType;
  final String? leadingIconKey;
  final TitleSubtitleConfig textConfig; // 타이틀/서브타이틀
  final ListItemType trailingType;
  final String? trailingIconKey;

  // 이미지 관련 설정
  final double imageSize;
  final double imageRadius;

  // 체크박스, 토글 설정
  final bool? checkboxValue;
  final bool? toggleValue;
  final ValueChanged<bool?>? onCheckboxChanged;
  final ValueChanged<bool>? onToggleChanged;

  // 아이콘 관련 설정 추가
  final IconSize leadingIconSize;
  final IconSize trailingIconSize;
  final Color? leadingIconColor;
  final Color? trailingIconColor;

  final CrossAxisAlignment alignment;

  const ListItemConfig({
    // 레이아웃 관련
    EdgeInsets? padding,
    this.itemSpacing = 4.0,

    // leading 관련
    this.leadingType = ListItemType.none,
    this.leadingIconKey,

    // 중앙 텍스트 관련
    this.textConfig = const TitleSubtitleConfig(),

    // trailing 관련
    this.trailingType = ListItemType.none,
    this.trailingIconKey,

    // 이미지 관련
    this.imageSize = 56.0,
    this.imageRadius = 8.0,

    // 상호작용 관련 (체크박스, 토글)
    this.checkboxValue,
    this.onCheckboxChanged,
    this.toggleValue,
    this.onToggleChanged,

    // 아이콘 커스터마이징 옵션 수정
    this.leadingIconSize = IconSize.medium,
    this.leadingIconColor,
    this.trailingIconColor,
    this.trailingIconSize = IconSize.small,
    this.alignment = CrossAxisAlignment.start,
  }) : padding =
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  static const defaultConfig = ListItemConfig();
}

class ListItemPresets {
  /// 아이콘 리스트 스타일
  static const ListItemConfig iconListStyle = ListItemConfig(
    itemSpacing: 12,
    leadingType: ListItemType.icon,
    textConfig: TitleSubtitlePresets.listItem,
    leadingIconSize: IconSize.medium,
    padding: EdgeInsets.zero,
  );

  /// 체크박스 리스트 스타일
  static const ListItemConfig checkboxListStyle = ListItemConfig(
    itemSpacing: 12,
    leadingType: ListItemType.checkbox,
    textConfig: TitleSubtitlePresets.listItem,
    padding: EdgeInsets.zero,
  );
}
