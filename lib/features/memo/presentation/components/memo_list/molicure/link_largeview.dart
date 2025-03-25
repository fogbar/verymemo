import 'dart:developer';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkLargeView extends StatelessWidget {
  final List<LinkModel> links;
  final Function(int index)? onDeleteTap;

  const LinkLargeView({
    super.key,
    required this.links,
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
  Widget build(BuildContext context) {
    return Column(
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
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (link.thumbnail != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          link.thumbnail!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.link),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    link.metaTitle ?? link.linkUrl ?? "",
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (link.metaDescription?.isNotEmpty == true) ...[
                    const SizedBox(height: 4),
                    Text(
                      link.metaDescription!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
