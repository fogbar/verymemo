import 'dart:developer';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/list.dart';
import 'package:verymemo/common/barrel/button.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkList extends ConsumerWidget {
  final Function(String url)? onLinkTap;
  final Function(int index)? onDeleteTap;

  const LinkList({
    super.key,
    this.onLinkTap,
    this.onDeleteTap,
  });

  Future<void> _launchUrl(String? url) async {
    if (url == null || url.isEmpty) {
      log('URL이 비어있습니다');
      return;
    }

    try {
      log('URL 실행 시도: $url');
      final uri = Uri.parse(url);

      final result = await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
      log('URL 실행 결과: $result');
    } catch (e) {
      log('URL 실행 중 오류 발생: $e');
      // 기본 브라우저로 시도
      try {
        final uri = Uri.parse(url);
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        log('기본 브라우저로도 실행 실패: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final links = ref.watch(memoProvider).maybeWhen(
          successed: (memos) => memos
              .expand((memo) => (memo.links ?? []).map((link) => (
                    link: link,
                    hasContent:
                        memo.content != null && memo.content!.isNotEmpty,
                    memoId: memo.memoId,
                  )))
              .toList(),
          orElse: () => <({LinkModel link, bool hasContent, int? memoId})>[],
        );

    return ListView.builder(
      itemCount: links.length + 2,
      itemBuilder: (context, index) {
        if (index == 0 || index == links.length + 1) {
          return const SizedBox(height: 8);
        }
        final linkData = links[index - 1];
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _launchUrl(linkData.link.linkUrl),
          child: ListItem(
            leadingImageUrl: linkData.link.thumbnail,
            title: linkData.link.metaTitle ?? linkData.link.linkUrl ?? "",
            subtitle: linkData.link.metaDescription ?? '',
            config: ListItemConfig(
              leadingType: ListItemType.image,
              imageSize: 56,
              imageRadius: 8,
              trailingType:
                  linkData.hasContent ? ListItemType.icon : ListItemType.none,
              trailingIconKey: 'memo',
              trailingIconSize: IconSize.small,
              trailingIconColor: Theme.of(context).colorScheme.onSurface,
              textConfig: TitleSubtitlePresets.listItem,
              itemSpacing: 12,
            ),
            onTrailingIconTap: linkData.hasContent && linkData.memoId != null
                ? () {
                    debugPrint('선택된 메모: ${linkData.memoId}');
                    context.push('/detail/${linkData.memoId}');
                  }
                : null,
          ),
        );
      },
    );
  }
}
