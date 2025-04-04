import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/button/icon_btn.dart';

class MemoFooter extends StatelessWidget {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isBookmarked;
  final VoidCallback? onBookmarkTap;

  const MemoFooter({
    super.key,
    required this.createdAt,
    this.updatedAt,
    this.isBookmarked = false,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayDate = updatedAt ?? createdAt;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatDate(displayDate),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
        ),
        if (isBookmarked) ...[
          IconBtn(
            iconKey: "bookmark",
            size: IconSize.small,
            color: Theme.of(context).colorScheme.primary,
            onTap: onBookmarkTap,
          ),
        ],
      ],
    );
  }

  String _formatDate(DateTime date) {
    String twoDigits(int n) =>
        n.toString().padLeft(2, '0'); // 한 자리 수를 두 자리로 만드는 헬퍼 함수

    return '${date.year}.${date.month}.${date.day} ${twoDigits(date.hour)}:${twoDigits(date.minute)}';
  }
}
