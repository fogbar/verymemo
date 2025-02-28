import 'package:flutter/material.dart';
import 'package:verymemo/common/utils/image_util.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'dart:math' as math;

/// ✅ 아이콘 크기 (소형, 중형, 대형)
enum IconSize { small, medium, large }

/// ✅ 원형 버튼 크기
enum CircleButtonSize {
  small, // 32.0
  medium, // 40.0
  large, // 56.0
}

/// ✅ 아이콘 설정 (경로, 크기, 색상)
class IconConfig {
  /// 📌 크기별 아이콘 사이즈 정의
  static const Map<IconSize, double> iconSizes = {
    IconSize.small: 20.0,
    IconSize.medium: 24.0,
    IconSize.large: 28.0,
  };

  /// 📌 SVG 아이콘 파일 경로 정의
  static const Map<String, String> icons = {
    "search": "assets/icons/search.svg",
    "sort": "assets/icons/sort.svg",
    "more": "assets/icons/more.svg",
    "back": "assets/icons/back.svg",
    "close": "assets/icons/close.svg",
    "delete": "assets/icons/delete.svg",
    "download": "assets/icons/download.svg",
    "memo": "assets/icons/memo.svg",
    "feed": "assets/icons/feed.svg",
    "copy": "assets/icons/copy.svg",
    "bookmark": "assets/icons/bookmark.svg",
    "upload": "assets/icons/upload.svg",
    "edit": "assets/icons/edit.svg",
    "arrow-up": "assets/icons/arrow-up.svg",
    "tag": "assets/icons/tag.svg",
    "camera": "assets/icons/camera.svg",
    "gallery": "assets/icons/gallery.svg",
    "link": "assets/icons/link.svg",
    "phone": "assets/icons/phone.svg",
    "star": "assets/icons/star.svg",
    "trash": "assets/icons/trash.svg",
    "mic": "assets/icons/mic.svg",
    "sync": "assets/icons/sync.svg",
    "check": "assets/icons/check.svg",
    "user": "assets/icons/user.svg",
  };

  /// 📌 아이콘 크기 가져오기 (기본값 medium)
  static double getIconSize(IconSize size) {
    return iconSizes[size] ?? iconSizes[IconSize.medium]!;
  }

  /// 📌 아이콘 경로 가져오기 (기본 아이콘 설정)
  static String getIconPath(dynamic icon) {
    if (icon is String) {
      if (icon.contains('/')) {
        // 직접 경로가 주어진 경우
        return icon;
      }
      // 미리 정의된 아이콘 키를 사용하는 경우
      return icons[icon] ?? "assets/icons/memo.svg";
    } else if (icon is IconData) {
      // Material 아이콘인 경우 PNG 경로로 변환
      return "assets/icons/${icon.codePoint}.png";
    }
    return "assets/icons/memo.svg";
  }

  /// 📌 원형 버튼 크기 정의
  static const Map<CircleButtonSize, double> circleSizes = {
    CircleButtonSize.small: 36.0, //라이팅 메뉴 바
    CircleButtonSize.medium: 48.0, //네브바 플로팅 (디자인 / 아직 안 씀)
    CircleButtonSize.large: 56.0, //이걸로 통일 중
  };

  /// 📌 원형 버튼 크기 가져오기 (기본값 large)
  static double getCircleSize(CircleButtonSize size) {
    return circleSizes[size] ?? circleSizes[CircleButtonSize.large]!;
  }
}

/// ✅ 아이콘 버튼 위젯
class IconBtn extends StatelessWidget {
  final dynamic iconKey; // String 또는 IconData를 받을 수 있도록 변경
  final VoidCallback? onTap;
  final IconSize size;
  final Color? color;
  final ButtonState state;
  final bool autoDisable;

  const IconBtn({
    super.key,
    required this.iconKey,
    this.onTap,
    this.size = IconSize.medium,
    this.color,
    this.state = ButtonState.transparent,
    this.autoDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveState = ButtonStateConfig.getEffectiveState(
      currentState: state,
      autoDisable: autoDisable,
      hasRequiredData: iconKey != null,
      hasOnPressed: onTap != null,
    );
    final (bgColor, fgColor) = ButtonStateConfig.getButtonColors(
      Theme.of(context).colorScheme,
      effectiveState,
    );

    final double iconSize = IconConfig.getIconSize(size);
    final String assetPath = IconConfig.getIconPath(iconKey);

    return InkWell(
      onTap: effectiveState == ButtonState.disabled ? null : onTap,
      child: SizedBox(
        width: math.max(iconSize, 44.0),
        height: math.max(iconSize, 44.0),
        child: Center(
          child: ImageUtil.showImage(
            assetPath,
            size: Size(iconSize, iconSize),
            colorFilter: ColorFilter.mode(
              color ?? fgColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

/// ✅ 원형 배경이 있는 아이콘 버튼 위젯
class IconCircleBtn extends StatelessWidget {
  final String iconKey;
  final ButtonState state;
  final CircleButtonSize circleSize;
  final Color? backgroundColor;
  final bool autoDisable;
  final VoidCallback? onTap;

  const IconCircleBtn({
    super.key,
    required this.iconKey,
    this.state = ButtonState.primary,
    this.circleSize = CircleButtonSize.medium,
    this.autoDisable = false,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveState = ButtonStateConfig.getEffectiveState(
      currentState: state,
      autoDisable: autoDisable,
      hasRequiredData: true,
      hasOnPressed: onTap != null,
    );

    final (bgColor, fgColor) = ButtonStateConfig.getButtonColors(
      Theme.of(context).colorScheme,
      effectiveState,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: IconConfig.getCircleSize(circleSize),
        height: IconConfig.getCircleSize(circleSize),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? bgColor,
        ),
        child: IconBtn(
          iconKey: iconKey,
          size: IconSize.medium,
          color: fgColor,
        ),
      ),
    );
  }
}
