import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple settings state for the Settings screen.
class SettingsState {
  final bool notificationsEnabled;
  final String currency;
  final String language;

  SettingsState({
    required this.notificationsEnabled,
    required this.currency,
    required this.language,
  });

  SettingsState copyWith({bool? notificationsEnabled, String? currency, String? language}) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      currency: currency ?? this.currency,
      language: language ?? this.language,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
      : super(SettingsState(notificationsEnabled: true, currency: 'US dollar', language: 'English'));

  void toggleNotifications() {
    state = state.copyWith(notificationsEnabled: !state.notificationsEnabled);
  }

  void setCurrency(String currency) {
    state = state.copyWith(currency: currency);
  }

  void setLanguage(String language) {
    state = state.copyWith(language: language);
  }
}

final settingsNotifierProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
