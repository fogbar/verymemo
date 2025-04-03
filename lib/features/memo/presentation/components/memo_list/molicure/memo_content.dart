import 'package:flutter/material.dart';

class MemoContent extends StatefulWidget {
  final String text;

  const MemoContent({
    super.key,
    required this.text,
  });

  @override
  State<MemoContent> createState() => _MemoContentState();
}

class _MemoContentState extends State<MemoContent> {
  bool isExpanded = false;
  static const int maxLines = 5;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          height: 1.4,
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        final tp = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: textStyle,
          ),
          textDirection: TextDirection.ltr,
          maxLines: maxLines,
        );

        tp.layout(maxWidth: constraints.maxWidth);
        final hasOverflow = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: textStyle,
              maxLines: isExpanded ? null : maxLines,
              overflow: isExpanded ? null : TextOverflow.ellipsis,
            ),
            if (hasOverflow)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? '닫기' : '더보기',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                        ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
