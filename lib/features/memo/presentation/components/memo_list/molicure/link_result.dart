import 'dart:developer';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/list.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkResult extends StatelessWidget {
  final List<LinkModel> links;
  final Function(int index)? onDeleteTap;
  final ListItemConfig config;

  const LinkResult({
    super.key,
    required this.links,
    this.onDeleteTap,
    this.config = const ListItemConfig(
      leadingType: ListItemType.image,
      imageSize: 60,
      imageRadius: 8,
      textConfig: TitleSubtitlePresets.listItem,
      itemSpacing: 12,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),
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
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100.0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            links.length,
            (index) {
              final link = links[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  log('링크 탭됨: ${link.linkUrl}');
                  _launchUrl(link.linkUrl);
                },
                child: ListItem(
                  leadingImageUrl: link.thumbnail,
                  title: link.metaTitle ?? link.linkUrl ?? "",
                  subtitle: link.metaDescription ?? '',
                  config: config,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
