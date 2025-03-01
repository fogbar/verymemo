import 'package:flutter/material.dart';
import 'avatar.dart';

class ProfileList extends StatelessWidget {
  final String? profileImageUrl;
  final String userName;
  final String description;

  const ProfileList({
    super.key,
    this.profileImageUrl,
    required this.userName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Avatar(
          config: AvatarConfig(
            imageUrl: profileImageUrl,
            avatarSize: 24.0,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          userName,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
