class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.thingspeak.com';
  static const String channelId = '2214906';
  static const String apiKey = 'TU_API_KEY_AQUI'; // Reemplaza con tu API key real de ThingSpeak
  
  // Endpoints
  static const String feedsEndpoint = '/channels/$channelId/feeds.json';
  
  // App Configuration
  static const String appName = 'EcoMonitor';
  static const String appVersion = '1.0.0';
  
  // Refresh intervals
  static const Duration refreshInterval = Duration(minutes: 5);
  static const Duration cacheExpiration = Duration(minutes: 10);
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double cardRadius = 12.0;
  static const double iconSize = 24.0;
  
  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}
