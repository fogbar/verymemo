import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/list.dart';
import 'package:verymemo/common/barrel/button.dart';

class LinkList extends StatelessWidget {
  final List<LinkModel> links;
  final Function(String url)? onLinkTap;
  final Function(int index)? onDeleteTap;

  const LinkList({
    super.key,
    required this.links,
    this.onLinkTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: links.length + 2,
      itemBuilder: (context, index) {
        if (index == 0 || index == links.length + 1) {
          return const SizedBox(height: 8);
        }
        final link = links[index - 1];
        return ListItem(
          leadingImageUrl: link.thumbnail,
          title: link.metaTitle ?? link.linkUrl ?? "",
          subtitle: link.metaDescription ?? '',
          config: ListItemConfig(
            leadingType: ListItemType.image,
            imageSize: 56,
            imageRadius: 8,
            trailingType: ListItemType.icon,
            trailingIconKey: 'memo',
            trailingIconSize: IconSize.small,
            trailingIconColor: Theme.of(context).colorScheme.onSurface,
            textConfig: TitleSubtitlePresets.listItem,
            itemSpacing: 12,
          ),
          onTap: () => onLinkTap?.call(link.linkUrl ?? ""),
          onTrailingIconTap: () => onDeleteTap?.call(index - 1),
        );
      },
    );
  }
}
