import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/network/dio_client.dart';
import 'package:sama_taxi/core/providers/auth_provider.dart';
import 'package:sama_taxi/features/auth/domain/models/customer.dart';

class AuthRepository {

  AuthRepository(this._dioClient, this._ref);
  final DioClient _dioClient;
  final Ref _ref;

  // Future<AuthResult> register({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final response = await _dioClient.register({
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //       'password_confirmation': password,
  //     });

  //     return _handleAuthResponse(
  //       response,
  //       fallbackEmail: email,
  //       fallbackName: name,
  //     );
  //   } on DioException catch (e) {
  //     return AuthResult.failure(_handleError(e));
  //   } catch (e) {
  //     return AuthResult.failure('Registration failed: ${e.toString()}');
  //   }
  // }

 Future<AuthResult> login({
  required String email,
  required String password,
}) async {
  try {
    debugPrint("Try to login to ${_dioClient.dio}");

    final response = await _dioClient.login({
      'email': email,
      'password': password,
    });

    // ✅ Parse API response directly into AuthResult
    final authResult = AuthResult.fromJson(response.data);
 debugPrint("Your response is : ${response.data}");

    // ✅ SUCCESS ACTION
    if (authResult.isSuccess) {
      debugPrint("Your response is : ${response.data}");
      // Save token
      if (authResult.token != null) {
        await _ref
            .read(authTokenProvider.notifier)
            .setToken(authResult.token!);
      }

      // Save user data
      if (authResult.customer != null) {
        await _ref
            .read(userDataProvider.notifier)
            .setUserData(authResult.customer!);
      }
    }

    return authResult;
  } on DioException catch (e) {
    return AuthResult.failure(_handleError(e));
  } catch (e) {
    return AuthResult.failure('Login failed: ${e.toString()}');
  }
}


Future<AuthResult> logout() async {
  try {
    await _dioClient.logout();

    await _ref.read(authTokenProvider.notifier).clearToken();
    await _ref.read(userDataProvider.notifier).clearUserData();

    return AuthResult.success(
      message: 'Logout successful',
      token: '',
      tokenType: '',
      expiresIn: 0,
      customer: Customer(
        id: 0,
        fullname: '',
        email: '',
        role: '',
        createdAt: '',
      ),
    );
  } on DioException {
    // ✅ Even if API fails, clear local data
    await _ref.read(authTokenProvider.notifier).clearToken();
    await _ref.read(userDataProvider.notifier).clearUserData();

    return AuthResult.success(
      message: 'Logout successful (offline)',
      token: '',
      tokenType: '',
      expiresIn: 0,
      customer: Customer(
        id: 0,
        fullname: '',
        email: '',
        role: '',
        createdAt: '',
      ),
    );
  } catch (e) {
    return AuthResult.failure('Logout failed: ${e.toString()}');
  }
}
Future<AuthResult> logoutAll() async {
  try {
    await _dioClient.logoutAll();

    await _ref.read(authTokenProvider.notifier).clearToken();
    await _ref.read(userDataProvider.notifier).clearUserData();

    return AuthResult.success(
      message: 'Logged out from all devices',
      token: '',
      tokenType: '',
      expiresIn: 0,
      customer: Customer(
        id: 0,
        fullname: '',
        email: '',
        role: '',
        createdAt: '',
      ),
    );
  } on DioException {
    // ✅ Even if API fails, clear local data
    await _ref.read(authTokenProvider.notifier).clearToken();
    await _ref.read(userDataProvider.notifier).clearUserData();

    return AuthResult.success(
      message: 'Logged out from all devices (offline)',
      token: '',
      tokenType: '',
      expiresIn: 0,
      customer: Customer(
        id: 0,
        fullname: '',
        email: '',
        role: '',
        createdAt: '',
      ),
    );
  } catch (e) {
    return AuthResult.failure('Logout failed: ${e.toString()}');
  }
}


  Future<AuthResult> getMe() async {
    final token = _ref.read(authTokenProvider);

    if (token == null || token.isEmpty) {
      return AuthResult.failure('No authentication token found');
    }

    try {
      final response = await _dioClient.getMe();
      final responseData = response.data as Map<String, dynamic>?;

      if (responseData == null) {
        return AuthResult.failure('Invalid response from server');
      }

      // Check if response has a 'data' field (nested structure)
      final data =
          responseData['data'] as Map<String, dynamic>? ?? responseData;

      Customer? customer;

      // Try to parse customer data from different possible structures
      if (data['customer'] != null) {
        customer = Customer.fromJson(data['customer'] as Map<String, dynamic>);
      } else if (data['user'] != null) {
        customer = Customer.fromJson(data['user'] as Map<String, dynamic>);
      } else if (data['id'] != null) {
        // Direct user data
        customer = Customer.fromJson(data);
      } else {
        return AuthResult.failure('User data not found in response');
      }

      return AuthResult.success(
      message: 'Logged out from all devices (offline)',
      token: '',
      tokenType: '',
      expiresIn: 0,
      customer: Customer(
        id: 0,
        fullname: '',
        email: '',
        role: '',
        createdAt: '',
      ),
    );
    } on DioException catch (e) {
      return AuthResult.failure(_handleError(e));
    } catch (e) {
      return AuthResult.failure('Failed to get user info: ${e.toString()}');
    }
  }

  /// Handle authentication response from API
  Future<AuthResult> _handleAuthResponse(
    Response response) async {
    final responseData = response.data as Map<String, dynamic>?;

    if (responseData == null) {
      return AuthResult.failure('Invalid response from server');
    }

    // Check if response has a 'data' field (nested structure)
    final data = responseData['data'] as Map<String, dynamic>? ?? responseData;

    // Handle different response structures for token
    final token =
        data['token'] ??
        '' ??
        data['access_token'] ??
        '' ??
        data['accessToken'] ??
        '';

    if (token == null) {
      return AuthResult.failure('No authentication token received from server');
    }

    Customer? customer;

    // Try to parse customer data from different possible structures
    if (data['customer'] != null) {
      customer = Customer.fromJson(data['customer'] as Map<String, dynamic>);
    } else if (data['user'] != null) {
      customer = Customer.fromJson(data['user'] as Map<String, dynamic>);
    } else if (data['id'] != null) {
      // Direct user data in response
      customer = Customer.fromJson(data);
    } else {
      return AuthResult.failure('User data not found in response');
    }

    // Save both token and user data to SharedPreferences
    await _ref.read(authTokenProvider.notifier).setToken(token);
    await _ref.read(userDataProvider.notifier).setUserData(customer);

    return AuthResult.success(
      message: 'Logged out from all devices (offline)',
      token: token,
      tokenType: 'b',
      expiresIn: 0,
      customer: Customer(
        id: 0,
        fullname: '',
        email: '',
        role: '',
        createdAt: '',
      ),
    );
  }

  String _handleError(DioException e) {
    switch (e.response?.statusCode) {
      case 401:
        return 'Invalid credentials';
      case 403:
        return 'Access forbidden';
      case 404:
        return 'Service not found';
      case 422:
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          return data['message'].toString();
        }
        return 'Validation error';
      case 500:
        return 'Server error. Please try again later';
      default:
        if (e.type == DioExceptionType.connectionTimeout) {
          return 'Connection timeout. Please check your internet connection';
        } else if (e.type == DioExceptionType.connectionError) {
          return 'Network error. Please check your internet connection';
        }
        return 'Network error. Please try again';
    }
  }
}

class AuthResult {
  final bool isSuccess;
  final String? message;
  final String? token;
  final String? tokenType;
  final int? expiresIn;
  final Customer? customer;
  final String? error;

  AuthResult({
    required this.isSuccess,
    this.message,
    this.token,
    this.tokenType,
    this.expiresIn,
    this.customer,
    this.error,
  });

  /// ✅ SUCCESS FACTORY
  factory AuthResult.success({
    required String message,
    required String token,
    required String tokenType,
    required int expiresIn,
    required Customer customer,
  }) {
    return AuthResult(
      isSuccess: true,
      message: message,
      token: token,
      tokenType: tokenType,
      expiresIn: expiresIn,
      customer: customer,
    );
  }

  /// ✅ FAILURE FACTORY
  factory AuthResult.failure(String error) {
    return AuthResult(
      isSuccess: false,
      error: error,
    );
  }

  /// ✅ DIRECT API PARSER
  factory AuthResult.fromJson(Map<String, dynamic> json) {
    final status = json['status'];

    if (status == 'success') {
      return AuthResult.success(
        message: json['message'],
        token: json['token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        customer: Customer.fromJson(json['user']),
      );
    } else {
      return AuthResult.failure(
        json['message'] ?? 'Unknown error occurred',
      );
    }
  }
}


final authRepositoryProvider = Provider<AuthRepository>((ref) => 
AuthRepository(ref.read(dioClientProvider), ref));
