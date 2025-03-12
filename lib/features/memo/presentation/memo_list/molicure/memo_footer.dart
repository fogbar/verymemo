import 'package:flutter/material.dart';

class MemoFooter extends StatelessWidget {
  final DateTime createdAt;

  const MemoFooter({
    super.key,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatDate(createdAt),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
        ),

        // 아이콘 추가 필요
      ],
    );
  }

  String _formatDate(DateTime date) {
    String twoDigits(int n) =>
        n.toString().padLeft(2, '0'); // 한 자리 수를 두 자리로 만드는 헬퍼 함수

    return '${date.year}.${date.month}.${date.day} ${twoDigits(date.hour)}:${twoDigits(date.minute)}';
  }
}
