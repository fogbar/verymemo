import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:verymemo/common/ui/common/config/login_channel_config.dart';
import 'package:verymemo/common/ui/common/config/login_channel.dart';
import 'package:verymemo/common/ui/components/layout/gap.dart';
import 'package:verymemo/common/utils/image_util.dart';
import 'package:verymemo/features/auth/presentation/providers/auth_provider.dart';
import 'package:verymemo/features/auth/presentation/providers/state/auth_state.dart';
import 'package:verymemo/routers/router.dart';
import 'package:verymemo/common/ui/components/button/round_btn.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/common/ui/common/config/config_box_style.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _offset = 10;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
        _offset = 0;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authStateNotifierProvider, (previous, current) {
      current.whenOrNull(
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
          log(message);
        },
      );
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img_join_screen.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Spacer(),
              // 로고와 텍스트 섹션
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 2000),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  transform: Matrix4.translationValues(0, _offset, 0),
                  child: Column(
                    children: [
                      ImageUtil.showImage(
                        "assets/images/logo.svg",
                        size: const Size(50, 25),
                      ),
                      const Gap(8),
                      Text(
                        "어디서든, 빠르게, 베리 메모",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(32),
              LoginButtonColumn(channels: loginChannelConfigs),
              const Gap(56),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButtonColumn extends StatelessWidget {
  final List<LoginChannel> channels;
  const LoginButtonColumn({super.key, required this.channels});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          channels.length,
          (index) => _LoginButton(
            channel: channels[index],
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends ConsumerWidget {
  final LoginChannel channel;
  const _LoginButton({required this.channel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.16; // 화면 너비의 24%
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 6),
      child: RoundBtn(
        size: BoxSize.small,
        iconSpacing: 4,
        text: channel.title,
        leadingIcon: channel.logo,
        onPressed: channel.isUser
            ? () {
                if (channel.title == "동기화를 위한 가입") {
                  ref
                      .read(authStateNotifierProvider.notifier)
                      .signIn(AuthProvider.google);
                } else {
                  ref
                      .read(authStateNotifierProvider.notifier)
                      .signIn(AuthProvider.apple);
                }
              }
            : () => context.go(AppRoute.home),
        state: channel.isUser ? ButtonState.white : ButtonState.transparent,
        isExpanded: true,
      ),
    );
  }
}
