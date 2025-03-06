import 'package:verymemo/common/configs/app_config.dart';
import 'package:verymemo/main/main.dart';

void main() {
  AppConfig.initialize(
    apiUrl: const String.fromEnvironment('API_URL',
        defaultValue: 'https://test-api.example.com'),
    environment: 'test',
    supabaseUrl: const String.fromEnvironment('SUPABASE_URL'),
    supabaseAnonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  mainCommon();
}
