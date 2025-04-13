class AppConfig {
  final String apiUrl;
  final String environment;
  // final String supabaseUrl;
  // final String supabaseAnonKey;

  AppConfig({
    required this.apiUrl,
    required this.environment,
    // required this.supabaseUrl,
    // required this.supabaseAnonKey,
  });

  static late AppConfig _instance;

  static AppConfig get instance => _instance;

  static void initialize({
    required String apiUrl,
    required String environment,
    // required String supabaseUrl,
    // required String supabaseAnonKey,
  }) {
    _instance = AppConfig(
      apiUrl: apiUrl,
      environment: environment,
      // supabaseUrl: supabaseUrl,
      // supabaseAnonKey: supabaseAnonKey,
    );
  }
}
