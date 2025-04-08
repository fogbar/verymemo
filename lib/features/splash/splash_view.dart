import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/splash/splash_viewmodel.dart';
import 'package:verymemo/features/splash/state/splash_state.dart';
import 'package:verymemo/routers/navigation_service.dart';
import 'package:verymemo/routers/router.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final navigationService = ref.watch(navigationServiceProvider);

    // // 🔄 splashState의 변화를 감지하고 처리
    // ref.listen<SplashState>(splashViewModelProvider, (previous, next) {
    //   next.when(
    //     loading: () => {},
    //     home: () => navigationService.pushAndRemoveUntil(AppRoute.home),
    //     intro: () => navigationService.pushAndRemoveUntil(AppRoute.intro),
    //     signup: () => navigationService.pushAndRemoveUntil(AppRoute.signup),
    //   );
    // });
    return Text("스플래시 뷰");
  }
}
