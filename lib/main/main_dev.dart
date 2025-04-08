import 'package:verymemo/common/configs/app_config.dart';
import 'package:verymemo/features/memo/data/providers/memo_repository_provider.dart';
import 'package:verymemo/main/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  AppConfig.initialize(
    apiUrl: const String.fromEnvironment('API_URL',
        defaultValue: 'https://dev-api.example.com'),
    environment: 'dev',
    supabaseUrl: const String.fromEnvironment('SUPABASE_URL'),
    supabaseAnonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  // 앱 시작 시 이미지 정리 실행
  final container = ProviderContainer();
  final memoRepository = container.read(memoRepositoryProvider);
  await memoRepository.cleanupUnusedImages();

  mainCommon();
}
