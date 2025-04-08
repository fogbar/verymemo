import 'dart:ui';

class LoginChannel {
  final String title;
  final String logo;
  final VoidCallback? onPressed;
  final bool isUser;
  final String provider;

  const LoginChannel({
    required this.title,
    required this.logo,
    required this.provider,
    this.onPressed,
    this.isUser = true,
  });
}
