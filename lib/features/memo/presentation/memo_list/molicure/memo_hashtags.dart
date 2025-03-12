import 'package:flutter/material.dart';

class MemoHashtags extends StatelessWidget {
  final List<String> hashtags;

  const MemoHashtags({
    super.key,
    required this.hashtags,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: hashtags
          .map((tag) => Text(
                '#$tag',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ))
          .toList(),
    );
  }
}
