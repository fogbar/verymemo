import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/button/icon_btn.dart';
import 'package:verymemo/common/ui/common/title_subtitle.dart';
import 'package:verymemo/common/ui/components/list/list/config_list_item.dart';
import 'package:verymemo/common/utils/image_util.dart';

class ListItem extends StatelessWidget {
  final ListItemConfig config;
  final String title;
  final String? subtitle;
  final String? leadingImageUrl;
  final String? leadingIconKey;
  final VoidCallback? onTap;
  final CrossAxisAlignment? alignment;

  const ListItem({
    super.key,
    required this.config,
    required this.title,
    this.subtitle,
    this.alignment,
    this.leadingImageUrl,
    this.leadingIconKey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: config.padding,
        child: Row(
          crossAxisAlignment: config.alignment,
          children: [
            if (config.leadingType != ListItemType.none) ...[
              _buildLeading(context),
              SizedBox(width: config.itemSpacing),
            ],
            Expanded(
              child: _buildTitleSubtitle(context),
            ),
            if (config.trailingType != ListItemType.none)
              _buildTrailing(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    switch (config.leadingType) {
      case ListItemType.image:
        return GestureDetector(
          onTap: () {},
          child: _buildImage(),
        );
      case ListItemType.icon:
        final double iconSize = IconConfig.getIconSize(config.leadingIconSize);
        final String assetPath = IconConfig.getIconPath(
            leadingIconKey ?? config.leadingIconKey ?? '');

        return SizedBox(
          width: iconSize,
          height: iconSize,
          child: ImageUtil.showImage(
            assetPath,
            size: Size(iconSize, iconSize),
            colorFilter: config.leadingIconColor != null
                ? ColorFilter.mode(config.leadingIconColor!, BlendMode.srcIn)
                : null,
          ),
        );
      case ListItemType.checkbox:
        return _buildCheckbox(context);
      case ListItemType.toggle:
        return _buildToggle();
      default:
        return const SizedBox();
    }
  }

  /// ✅ 타이틀 & 서브타이틀 빌드
  Widget _buildTitleSubtitle(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: TitleSubtitleWidget(
        title: title,
        subtitle: subtitle,
        config: config.textConfig,
      ),
    );
  }

  /// ✅ 트레일링 아이템 빌드 (아이콘 버튼, 토글 등)
  Widget _buildTrailing(BuildContext context) {
    Widget trailingWidget;
    switch (config.trailingType) {
      case ListItemType.icon:
        trailingWidget = config.trailingIconKey != null
            ? IconBtn(
                iconKey: config.trailingIconKey!,
                onTap: () {},
                size: IconSize.medium,
                color: config.trailingIconColor,
              )
            : const SizedBox();
        break;
      case ListItemType.toggle:
        trailingWidget = _buildToggle();
        break;
      default:
        trailingWidget = const SizedBox();
    }

    return trailingWidget;
  }

  /// ✅ 리딩 이미지 빌드 (클립된 썸네일)
  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(config.imageRadius),
      child: SizedBox.square(
        dimension: config.imageSize,
        child: leadingImageUrl != null
            ? Image.network(leadingImageUrl!, fit: BoxFit.cover)
            : Container(color: Colors.grey[300]),
      ),
    );
  }

  /// ✅ 체크박스 빌드
  Widget _buildCheckbox(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-8, -8),
      child: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          value: config.checkboxValue ?? false,
          onChanged: (bool? newValue) {
            if (config.onCheckboxChanged != null) {
              config.onCheckboxChanged!(newValue);
            }
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  /// ✅ 토글 스위치 빌드
  Widget _buildToggle() {
    return Switch(
      value: config.toggleValue ?? false,
      onChanged: config.onToggleChanged,
      inactiveTrackColor: Colors.grey[300],
      inactiveThumbColor: Colors.white,
    );
  }
}
