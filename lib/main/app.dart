import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/routers/router.dart';
import 'package:verymemo/features/settings/providers/theme_providers.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(
        debugLabel: "scaffold_key",
      ),
      routerConfig: router.config,
      theme: theme,
      darkTheme: theme,
      themeMode:
          ref.watch(isDarkModeProvider) ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
