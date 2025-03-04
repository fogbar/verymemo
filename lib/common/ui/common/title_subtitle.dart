import 'package:flutter/material.dart';

/// ✅ 타이틀 크기 (소형, 중형, 대형)
enum TitleSize { small, medium, large, exlarge }

/// ✅ 타이틀 정렬 (왼쪽, 중앙)
enum TitleAlignment { left, center }

/// ✅ 타이틀 & 서브타이틀 설정 (스타일 및 속성)
class TitleSubtitleConfig {
  final TitleSize titleSize;
  final TitleAlignment alignment;
  final int? titleMaxLines;
  final int? subtitleMaxLines;
  final double? spacing;

  const TitleSubtitleConfig({
    this.titleSize = TitleSize.medium,
    this.alignment = TitleAlignment.left,
    this.titleMaxLines,
    this.subtitleMaxLines,
    this.spacing,
  });

  /// 📌 타이틀 스타일 반환
  TextStyle getTitleStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return switch (titleSize) {
      TitleSize.exlarge => textTheme.headlineSmall!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      TitleSize.large => textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      TitleSize.medium => textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      TitleSize.small => textTheme.titleSmall!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
    };
  }

  /// 📌 서브타이틀 스타일 반환
  TextStyle getSubtitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );
  }

  /// 📌 정렬 방식 반환
  CrossAxisAlignment getCrossAxisAlignment() {
    return alignment == TitleAlignment.left
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center;
  }
}

/// ✅ 타이틀 & 서브타이틀 위젯
class TitleSubtitleWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double? spacing;
  final TitleSubtitleConfig config;
  final TextAlign? textAlign;

  const TitleSubtitleWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.spacing,
    this.config = const TitleSubtitleConfig(),
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: config.getCrossAxisAlignment(),
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: config.getTitleStyle(context),
            textAlign: textAlign,
            maxLines: config.titleMaxLines,
            overflow: config.titleMaxLines != null
                ? TextOverflow.ellipsis
                : TextOverflow.visible,
          ),
          if (spacing != null) SizedBox(height: spacing),
          if (subtitle != null) ...[
            if (config.spacing != null) SizedBox(height: config.spacing),
            Text(
              subtitle!,
              style: config.getSubtitleStyle(context),
              textAlign: textAlign,
              maxLines: config.subtitleMaxLines,
              overflow: config.subtitleMaxLines != null
                  ? TextOverflow.ellipsis
                  : TextOverflow.visible,
            ),
          ],
        ],
      ),
    );
  }
}

/// ✅ 타이틀 & 서브타이틀 프리셋 (미리 정의된 스타일)
class TitleSubtitlePresets {
  /// 📌 모달 팝업용
  static const TitleSubtitleConfig modalPopup = TitleSubtitleConfig(
    titleSize: TitleSize.large,
    alignment: TitleAlignment.center,
  );

  /// 📌 리스트 아이템용
  static const TitleSubtitleConfig listItem = TitleSubtitleConfig(
    titleSize: TitleSize.small,
    titleMaxLines: 1,
    alignment: TitleAlignment.left,
  );

  /// 📌 멀티라인 타이틀용
  static const multiLine = TitleSubtitleConfig(
    titleSize: TitleSize.exlarge,
    spacing: 8,
    alignment: TitleAlignment.left,
  );
}
