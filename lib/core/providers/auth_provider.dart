import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sama_taxi/core/services/user_preferences_service.dart';
import 'package:sama_taxi/features/auth/domain/models/customer.dart';

class AuthTokenNotifier extends StateNotifier<String?> {
  AuthTokenNotifier() : super(null) {
    _loadToken();
  }

  static const String _tokenKey = 'auth_token';

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString(_tokenKey);
  }

  Future<void> setToken(String token) async {
    state = token;
    await UserPreferencesService.saveToken(token);
  }

  Future<void> clearToken() async {
    state = null;
    await UserPreferencesService.clearUserData();
  }
}

class UserDataNotifier extends StateNotifier<Customer?> {
  UserDataNotifier() : super(null) {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await UserPreferencesService.getUserData();
    state = userData;
  }

  Future<void> setUserData(Customer customer) async {
    state = customer;
    await UserPreferencesService.saveUserData(customer);
  }

  Future<void> updateUserData(Customer customer) async {
    state = customer;
    await UserPreferencesService.updateUserData(customer);
  }

  Future<void> clearUserData() async {
    state = null;
    await UserPreferencesService.clearUserData();
  }
}

final authTokenProvider = StateNotifierProvider<AuthTokenNotifier, String?>(
  (ref) => AuthTokenNotifier(),
);

final userDataProvider = StateNotifierProvider<UserDataNotifier, Customer?>(
  (ref) => UserDataNotifier(),
);
