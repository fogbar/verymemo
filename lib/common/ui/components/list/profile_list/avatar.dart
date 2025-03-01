import 'package:verymemo/common/barrel/view_common.dart';

enum AvatarType {
  profile,
  comment,
  list,
  thumbnail,
}

class AvatarConfig {
  final double avatarSize;
  final String? imageUrl;
  final AvatarType type;

  const AvatarConfig({
    required this.avatarSize,
    this.imageUrl,
    this.type = AvatarType.profile,
  });

  String get defaultImagePath {
    return 'assets/images/default_profile_avatar.png'; // 일단 하나로 고정
  }
}

//아바타 위젯
class Avatar extends StatelessWidget {
  final AvatarConfig config;

  const Avatar({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = config.imageUrl?.isNotEmpty == true
        ? config.imageUrl!
        : config.defaultImagePath;
    ('Using image path: $imagePath');

    return Container(
      width: config.avatarSize,
      height: config.avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
      ),
      child: config.imageUrl?.isNotEmpty == true
          ? ClipOval(
              child: Image.network(
                config.imageUrl!,
                width: config.avatarSize,
                height: config.avatarSize,
                fit: BoxFit.cover,
              ),
            )
          : Image.asset(
              config.defaultImagePath,
              width: config.avatarSize,
              height: config.avatarSize,
              fit: BoxFit.cover,
            ),
    );
  }
}
