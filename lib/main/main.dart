import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/configs/app_config.dart';
import 'package:verymemo/externals/db/db_scheme.dart';
import 'package:verymemo/externals/db/db_service.dart';
import 'package:verymemo/features/memo/data/providers/memo_repository_provider.dart';
import 'package:verymemo/firebase_options.dart';
import 'package:verymemo/main/app.dart';

final dbContainer = ProviderContainer();

Future<void> main() async {
  print("main call");
  WidgetsFlutterBinding.ensureInitialized();

  // 환경 설정 초기화
  final environment =
      const String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
  final apiUrl = const String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://dev-api.example.com',
  );

  AppConfig.initialize(
    apiUrl: apiUrl,
    environment: environment,
  );

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 데이터베이스 초기화
  final dbInit = dbContainer.read(dbServiceProvider).initDB(dbSchemes);
  await dbInit;

  // 앱 시작 시 이미지 정리 실행
  final memoRepository = dbContainer.read(memoRepositoryProvider);
  await memoRepository.cleanupUnusedImages();

  runApp(const ProviderScope(child: App()));
}
