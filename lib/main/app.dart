import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/externals/db/db_service.dart';
import 'package:verymemo/features/auth/presentation/providers/auth_provider.dart';
import 'package:verymemo/features/auth/presentation/providers/state/auth_state.dart';
import 'package:verymemo/routers/router.dart';
import 'package:verymemo/features/settings/providers/theme_providers.dart';

// main.dart 또는 최상위 파일
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(themeProvider);
    final dbService = ref.watch(dbServiceProvider);

    // auth 관리를 최상단에서 관리
    // 공유하기 등과 더불어 유저 현재 상태에 따라 화면 이동 및 sharedPreference 등을
    // 모두 관리하기 위함
    // 기존 splashState 와 AuthState 를 합쳐서 최상단에서 모든 라우팅 분기를 관리하도록 한다.
    ref.listen<AuthState>(authStateNotifierProvider, (previous, current) {
      current.whenOrNull(
        error: (message) {
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text(message)),
          );
          log(message);
        },
      );
    });

    return PopScope(
      canPop: false, // 앱 종료 방지
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerConfig: router.config,
        theme: theme,
        darkTheme: theme,
        themeMode:
            ref.watch(isDarkModeProvider) ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
