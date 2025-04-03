import 'package:flutter/material.dart';

class MemoContent extends StatefulWidget {
  final String text;
  final String? searchQuery;

  const MemoContent({
    super.key,
    required this.text,
    this.searchQuery,
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

    final highlightStyle = textStyle?.copyWith(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      color: Theme.of(context).colorScheme.primary,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final tp = TextPainter(
          text: TextSpan(text: widget.text, style: textStyle),
          textDirection: TextDirection.ltr,
          maxLines: maxLines,
        );

        tp.layout(maxWidth: constraints.maxWidth);
        final hasOverflow = tp.didExceedMaxLines;

        Widget textContent;
        if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
          final pattern = RegExp(widget.searchQuery!, caseSensitive: false);
          final spans = <TextSpan>[];
          int start = 0;

          for (final match in pattern.allMatches(widget.text)) {
            if (match.start > start) {
              spans.add(TextSpan(
                text: widget.text.substring(start, match.start),
                style: textStyle,
              ));
            }
            spans.add(TextSpan(
              text: widget.text.substring(match.start, match.end),
              style: highlightStyle,
            ));
            start = match.end;
          }

          if (start < widget.text.length) {
            spans.add(TextSpan(
              text: widget.text.substring(start),
              style: textStyle,
            ));
          }

          textContent = Text.rich(
            TextSpan(children: spans),
            maxLines: isExpanded ? null : maxLines,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          );
        } else {
          textContent = Text(
            widget.text,
            style: textStyle,
            maxLines: isExpanded ? null : maxLines,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            textContent,
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
