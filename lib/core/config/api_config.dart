/// API configuration constants
class ApiConfig {
  // Base URL for your API
  static const String baseUrl =  "https://samataxi.net/paneldb/";
  //'https://tripstationksa.com/api';

  // Full API base URL
  static const String fullApiUrl = '$baseUrl/paneldb/';

  // Timeout configurations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Request headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
