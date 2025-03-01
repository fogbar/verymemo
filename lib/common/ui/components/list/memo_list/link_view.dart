import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/list.dart';
import 'package:verymemo/common/barrel/button.dart';

class LinkList extends StatelessWidget {
  // final List<MemoListModel> memos;
  final Function(String url)? onLinkTap;

  const LinkList({super.key, this.onLinkTap});

  @override
  Widget build(BuildContext context) {
    var viewModel = MemoListViewModel();
    final links = viewModel.extractLinks();

    return ListView.builder(
      // padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: links.length + 2,
      itemBuilder: (context, index) {
        if (index == 0 || index == links.length + 1) {
          return const SizedBox(height: 8);
        }
        final link = links[index - 1];
        return ListItem(
          leadingImageUrl: link.thumbnail,
          title: link.metaTitle ?? link.url,
          subtitle: link.metaDescription ?? '',
          config: ListItemConfig(
            leadingType: ListItemType.image,
            imageSize: 56,
            imageRadius: 8,
            trailingType: ListItemType.icon,
            trailingIconKey: 'memo',
            trailingIconSize: IconSize.small,
            textConfig: TitleSubtitlePresets.listItem,
            itemSpacing: 12,
          ),
          onTap: () => onLinkTap?.call(link.url),
        );
      },
    );
  }
}
