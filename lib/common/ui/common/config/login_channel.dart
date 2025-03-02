import 'dart:ui';

class LoginChannel {
  final String title;
  final String logo;
  final VoidCallback? onPressed;
  final bool isUser;

  const LoginChannel({
    required this.title,
    required this.logo,
    this.onPressed,
    this.isUser = true,
  });
}
