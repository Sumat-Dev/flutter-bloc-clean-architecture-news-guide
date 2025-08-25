class AppConfig {
  static const String appName = 'News App';
  static const String appVersion = '1.0.0';

  // Development Configuration
  static const bool useMockData =
      true; // Set to false when you have a real API key

  // API Configuration
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey =
      'YOUR_API_KEY'; // Replace with your actual API key from newsapi.org

  // Endpoints
  static const String topHeadlinesEndpoint = '/top-headlines';
  static const String everythingEndpoint = '/everything';

  // Default parameters
  static const String defaultCountry = 'us';
  static const String defaultCategory = 'general';
  static const int defaultPageSize = 20;

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Cache settings
  static const Duration cacheExpiration = Duration(hours: 1);
}
