import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/button/icon_btn.dart';
import 'package:verymemo/common/utils/image_util.dart';
import 'package:intl/intl.dart';

enum HeaderType { date, logo, content, searchBar, imageviewer, memoDetail }

class HeaderConfig {
  final bool showBackArrow;
  final bool showSearch;
  final bool showSort;
  final bool showMore;
  final bool showDelete;
  final bool showDownload;
  final bool showClose;
  final bool showDeleteAllButton;
  final bool showShare;
  final VoidCallback? onDeleteAllPressed;

  const HeaderConfig({
    this.showBackArrow = false,
    this.showSearch = false,
    this.showSort = false,
    this.showMore = false,
    this.showDelete = false,
    this.showDownload = false,
    this.showClose = false,
    this.showDeleteAllButton = false,
    this.onDeleteAllPressed,
    this.showShare = false,
  });

  static const Map<HeaderType, HeaderConfig> styles = {
    HeaderType.date: HeaderConfig(
      showSort: true,
      showSearch: true,
      showMore: true,
    ),
    HeaderType.logo: HeaderConfig(showMore: true),
    HeaderType.content: HeaderConfig(showBackArrow: true),
    HeaderType.searchBar: HeaderConfig(showBackArrow: true, showSearch: true),
    HeaderType.imageviewer: HeaderConfig(
      showDownload: false,
      showDelete: false,
      showClose: true,
    ),
    HeaderType.memoDetail: HeaderConfig(
      showBackArrow: true,
      showDelete: true,
      showShare: true,
    ),
  };
}

//변수 헤더 위젯
class VariableHeader extends StatelessWidget {
  final HeaderType type;
  final VoidCallback? onBack;
  final VoidCallback? onSearch;
  final Function(String)? onSearchChanged;
  final VoidCallback? onSearchClear;
  final VoidCallback? onSort;
  final VoidCallback? onMore;
  final VoidCallback? onDelete;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;
  final bool showDelete;
  final bool showDownload;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const VariableHeader({
    super.key,
    required this.type,
    this.onBack,
    this.onSearch,
    this.onSearchChanged,
    this.onSearchClear,
    this.onSort,
    this.onMore,
    this.onDelete,
    this.onDownload,
    this.onShare,
    this.showDelete = true,
    this.showDownload = true,
    this.focusNode,
    this.controller,
  });

  String _getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('yyyy.M.d').format(now);
  }

  @override
  Widget build(BuildContext context) {
    final HeaderConfig config = HeaderConfig.styles[type]!;
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = type == HeaderType.imageviewer
        ? colorScheme.surfaceContainerHighest
        : colorScheme.surface;
    final iconColor = type == HeaderType.imageviewer
        ? colorScheme.onPrimary
        : colorScheme.onSurface;

    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 56,
        color: backgroundColor,
        alignment: Alignment.center,
        child: _buildHeaderContent(config, context, iconColor),
      ),
    );
  }

  Widget _buildHeaderContent(
      HeaderConfig config, BuildContext context, Color iconColor) {
    switch (type) {
      case HeaderType.date:
        return _dateHeader(config, context, iconColor);
      case HeaderType.logo:
        return _logoHeader(config, context, iconColor);
      case HeaderType.content:
        return _contentHeader(config, context, iconColor);
      case HeaderType.searchBar:
        return _searchBarHeader(config, context, iconColor);
      case HeaderType.imageviewer:
        return _imageViewerHeader(config, context, iconColor);
      case HeaderType.memoDetail:
        return _memoDetailHeader(config, context, iconColor);
    }
  }

  Widget _dateHeader(
      HeaderConfig config, BuildContext context, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _getCurrentDate(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          children: [
            if (config.showSort)
              IconBtn(iconKey: "sort", onTap: onSort, color: iconColor),
            if (config.showSearch)
              IconBtn(iconKey: "search", onTap: onSearch, color: iconColor),
            if (config.showMore)
              IconBtn(iconKey: "more", onTap: onMore, color: iconColor),
          ],
        ),
      ],
    );
  }

  Widget _logoHeader(
      HeaderConfig config, BuildContext context, Color iconColor) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              ImageUtil.showImage(
                'assets/images/logo.svg',
                height: 22,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              )
            ],
          ),
        ),
        if (config.showMore)
          IconBtn(iconKey: "more", onTap: onMore, color: iconColor),
      ],
    );
  }

  Widget _contentHeader(
      HeaderConfig config, BuildContext context, Color iconColor) {
    return Row(
      children: [
        if (config.showBackArrow)
          IconBtn(iconKey: "back", onTap: onBack, color: iconColor),
        const Spacer(),
        if (config.showDeleteAllButton)
          TextButton(
            onPressed: () {
              // 전체 삭제 기능 실행
              if (config.onDeleteAllPressed != null) {
                config.onDeleteAllPressed!();
              }
            },
            child: Text(
              "전체 선택",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                  ),
            ),
          ),
      ],
    );
  }

  Widget _searchBarHeader(
      HeaderConfig config, BuildContext context, Color iconColor) {
    return Row(
      children: [
        if (config.showBackArrow)
          SizedBox(
            width: 48,
            child: IconBtn(iconKey: "back", onTap: onBack, color: iconColor),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              autofocus: true,
              focusNode: focusNode,
              controller: controller,
              decoration: InputDecoration(
                hintText: "검색어를 입력하세요",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconBtn(
                  iconKey: "search",
                  onTap: onSearch,
                  color: iconColor,
                ),
              ),
              onChanged: onSearchChanged,
              onSubmitted: (_) => onSearch?.call(),
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageViewerHeader(
      HeaderConfig config, BuildContext context, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            if (showDownload)
              IconBtn(iconKey: "download", onTap: onDownload, color: iconColor),
            if (showDelete)
              IconBtn(iconKey: "delete", onTap: onDelete, color: iconColor),
            if (config.showClose)
              IconBtn(iconKey: "close", onTap: onBack, color: iconColor),
          ],
        ),
      ],
    );
  }

  Widget _memoDetailHeader(
      HeaderConfig config, BuildContext context, Color iconColor) {
    return Row(
      children: [
        if (config.showBackArrow)
          IconBtn(iconKey: "back", onTap: onBack, color: iconColor),
        const Spacer(),
        Row(
          children: [
            if (config.showDelete)
              IconBtn(iconKey: "delete", onTap: onDelete, color: iconColor),
            if (config.showShare)
              IconBtn(iconKey: "share", onTap: onShare, color: iconColor),
          ],
        ),
      ],
    );
  }
}
