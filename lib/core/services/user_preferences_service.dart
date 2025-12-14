import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sama_taxi/features/auth/domain/models/customer.dart';

class UserPreferencesService {
  static const String _userKey = 'user_data';
  static const String _tokenKey = 'auth_token';
  static const String _isLoggedInKey = 'is_logged_in';

  // Save user data to SharedPreferences
  static Future<void> saveUserData(Customer customer) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(customer);
    await prefs.setString(_userKey, userJson);
    await prefs.setBool(_isLoggedInKey, true);
  }

  // Get user data from SharedPreferences
  static Future<Customer?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    if (userJson != null) {
      try {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        return Customer.fromJson(userMap);
      } catch (e) {
        // If parsing fails, clear the corrupted data
        await clearUserData();
        return null;
      }
    }
    return null;
  }

  // Save authentication token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get authentication token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Clear all user data (logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_tokenKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Update user data
  static Future<void> updateUserData(Customer customer) async {
    await saveUserData(customer);
  }
}
