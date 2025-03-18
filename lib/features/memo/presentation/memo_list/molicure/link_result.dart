import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/list.dart';

class LinkResult extends StatelessWidget {
  final List<LinkModel> links;
  final Function(int index)? onDeleteTap;

  const LinkResult({
    super.key,
    required this.links,
    this.onDeleteTap,
  });

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
              return ListItem(
                leadingImageUrl: link.thumbnail,
                title: link.metaTitle ?? link.linkUrl ?? "",
                subtitle: link.metaDescription ?? '',
                config: ListItemConfig(
                  leadingType: ListItemType.image,
                  imageSize: 60,
                  imageRadius: 8,
                  textConfig: TitleSubtitlePresets.listItem,
                  itemSpacing: 12,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
