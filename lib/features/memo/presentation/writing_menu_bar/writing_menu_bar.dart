import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/common/ui/components/button/icon_btn.dart';
import 'package:verymemo/features/memo/presentation/viewmodels/memo_writing_viewmodel.dart';
import 'package:verymemo/features/memo/presentation/writing_menu_bar/config_writing_menu_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WritingMenuBar extends ConsumerWidget {
  final VoidCallback? onCameraTap;
  final VoidCallback? onGalleryTap;
  final VoidCallback? onLinkTap;
  final VoidCallback? onPrivacyTap;
  final VoidCallback? onTagTap;
  final VoidCallback? onUploadTap;

  const WritingMenuBar({
    super.key,
    this.onCameraTap,
    this.onGalleryTap,
    this.onLinkTap,
    this.onPrivacyTap,
    this.onTagTap,
    this.onUploadTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ), // ✅ 전체 패딩
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// ✅ 왼쪽 아이콘 그룹 (Expanded 적용)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: WritingMenuBarConfig.leadingIcons
                  .map((icon) => _buildLeadingIcon(icon, context))
                  .toList(),
            ),
          ),

          /// ✅ 오른쪽 아이콘 그룹
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: WritingMenuBarConfig.trailingIcons
                .map((icon) => _buildTrailingIcon(icon, context, ref))
                .toList(),
          ),
        ],
      ),
    );
  }

  /// ✅ 리딩 아이콘 빌드 (카메라, 갤러리, 링크, 비공개)
  Widget _buildLeadingIcon(LeadingIcon icon, BuildContext context) {
    switch (icon) {
      case LeadingIcon.camera:
        return IconBtn(
          iconKey: "camera",
          onTap: onCameraTap,
          size: WritingMenuBarConfig.iconSize,
        );
      case LeadingIcon.gallery:
        return IconBtn(
          iconKey: "gallery",
          onTap: onGalleryTap,
          size: WritingMenuBarConfig.iconSize,
        );
      case LeadingIcon.link:
        return IconBtn(
          iconKey: "link",
          onTap: onLinkTap,
        );
      case LeadingIcon.privacy:
        return _textButton("비공개", onPrivacyTap, context);
    }
  }

  /// ✅ 트레일링 아이콘 빌드 (태그, 업로드)
  Widget _buildTrailingIcon(
      TrailingIcon icon, BuildContext context, WidgetRef ref) {
    switch (icon) {
      case TrailingIcon.tag:
        return IconBtn(
          iconKey: "tag",
          onTap: onTagTap,
          size: WritingMenuBarConfig.iconSize,
        );
      case TrailingIcon.upload:
        final buttonState = ref.watch(memoWritingViewModelProvider).buttonState;
        return IconCircleBtn(
          iconKey: "arrow-up",
          onTap: buttonState == ButtonState.disabled ? null : onUploadTap,
          state: buttonState,
          circleSize: CircleButtonSize.small,
        );
    }
  }

  /// ✅ 텍스트 버튼 (비공개 버튼 - 나중에 만들기)
  Widget _textButton(String text, VoidCallback? onTap, BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }
}
