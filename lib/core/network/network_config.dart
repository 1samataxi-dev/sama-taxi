import 'dart:io' show Platform; // Still allowed, but guarded
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sama_taxi/core/config/api_config.dart';

/// Network configuration for different platforms
class NetworkConfig {
  /// Get platform-specific Dio configuration
  static BaseOptions getPlatformBaseOptions({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) =>
      BaseOptions(
        baseUrl: baseUrl ?? _getDefaultBaseUrl(),
        connectTimeout: connectTimeout ?? ApiConfig.connectTimeout,
        receiveTimeout: receiveTimeout ?? ApiConfig.receiveTimeout,
        sendTimeout: sendTimeout ?? ApiConfig.sendTimeout,
        headers: _getDefaultHeaders(),
        validateStatus: (status) => status != null && status < 500,
        followRedirects: true,
        maxRedirects: 3,
        extra: _getPlatformSpecificConfig(),
      );

  /// Get default base URL based on environment
  static String _getDefaultBaseUrl() => ApiConfig.baseUrl;

  /// Get default headers
  static Map<String, String> _getDefaultHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': _getUserAgent(),
      };

  /// SAFE user-agent across all platforms (web included)
  static String _getUserAgent() {
    if (kIsWeb) return "sama_taxiApp/1.0 (Web)";

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return "sama_taxiApp/1.0 (iOS)";
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return "sama_taxiApp/1.0 (Android)";
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      return "sama_taxiApp/1.0 (macOS)";
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      return "sama_taxiApp/1.0 (Windows)";
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      return "sama_taxiApp/1.0 (Linux)";
    }

    return "sama_taxiApp/1.0";
  }

  /// SAFE platform-specific configuration
  static Map<String, dynamic> _getPlatformSpecificConfig() {
    final config = <String, dynamic>{};

    // macOS-specific code (must NOT run on web)
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.macOS) {
      config['macOS'] = {
        'allowInsecureConnections': kDebugMode,
        'certificateValidation': !kDebugMode,
      };
    }

    return config;
  }

  /// Create a Dio instance with platform-specific configuration
  static Dio createDio({String? baseUrl, List<Interceptor>? interceptors}) {
    final dio = Dio(getPlatformBaseOptions(baseUrl: baseUrl));

    // Add default interceptors
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }

    _addPlatformInterceptors(dio);

    return dio;
  }

  /// SAFE interceptors
  static void _addPlatformInterceptors(Dio dio) {
    // macOS-specific handling — but NOT on Web
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.macOS) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onError: (error, handler) {
            if (error.type == DioExceptionType.connectionError) {
              handler.next(
                DioException(
                  requestOptions: error.requestOptions,
                  type: DioExceptionType.connectionError,
                  message:
                      'Network connection failed. Please check your internet connection and firewall settings.',
                  error: error.error,
                ),
              );
            } else {
              handler.next(error);
            }
          },
        ),
      );
    }

    // Debug logging
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => debugPrint(obj.toString()),
        ),
      );
    }
  }

  /// SAFE network info summary
  static Map<String, dynamic> getNetworkInfo() => {
        'platform': kIsWeb
            ? "web"
            : defaultTargetPlatform.name, // NO Platform.operatingSystem
        'version': kIsWeb ? "unknown" : Platform.operatingSystemVersion,
        'isDebug': kDebugMode,
        'baseUrl': _getDefaultBaseUrl(),
        'userAgent': _getUserAgent(),
      };
}
