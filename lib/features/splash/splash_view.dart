import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/utils/platform_util.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});
  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    /// 1. DeviceId가 저장되어 있는지 체크
    ///  - O
    ///   - UserModel이 저장되어 있는지 체크
    ///     - O
    ///       - 회원 / 비회원 -> 저장된 UserModel을 메모리에 올림
    ///       - AppRoute.home 으로 보냄
    ///     - X : 최초는 X, 가입정보 입력 X
    ///       - AppRoute.auth로 보내버림
    ///
    ///   - X : 최초 접근인 경우
    ///    -> AppRoute.intro 로 보내버림
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
