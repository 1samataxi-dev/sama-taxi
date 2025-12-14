import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String onboardingKey = 'has_completed_onboarding';

  // Get all stored preferences for debugging
  static Future<Map<String, dynamic>> getAllPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      final allPrefs = <String, dynamic>{};

      for (var key in keys) {
        final value = prefs.get(key);
        allPrefs[key] = value;
      }

      return allPrefs;
    } catch (e) {
      print('Error getting all preferences: $e');
      return {};
    }
  }

  // Clear all preferences (for testing)
  static Future<void> clearAllPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print('All SharedPreferences cleared');
    } catch (e) {
      print('Error clearing preferences: $e');
    }
  }

  // Specific onboarding helpers
  static Future<bool> getOnboardingStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(onboardingKey) ?? false;
    } catch (e) {
      print('Error getting onboarding status: $e');
      return false;
    }
  }

  static Future<void> setOnboardingStatus(bool completed) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(onboardingKey, completed);
      print('Onboarding status set to: $completed');
    } catch (e) {
      print('Error setting onboarding status: $e');
    }
  }

  // Debug method to print all preferences
  static Future<void> debugPrintAllPreferences() async {
    final allPrefs = await getAllPreferences();
    print('=== SharedPreferences Debug ===');
    if (allPrefs.isEmpty) {
      print('No preferences found');
    } else {
      allPrefs.forEach((key, value) {
        print('$key: $value (${value.runtimeType})');
      });
    }
    print('==============================');
  }
}
