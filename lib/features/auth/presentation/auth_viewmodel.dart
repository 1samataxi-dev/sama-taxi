import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/providers/auth_provider.dart';
import 'package:sama_taxi/core/services/logging_service.dart';
import 'package:sama_taxi/core/services/user_preferences_service.dart';
import 'package:sama_taxi/features/auth/data/auth_repository.dart';
import 'package:sama_taxi/features/auth/domain/auth_state.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this._authRepository, this._ref)
    : super(AuthState(isLoading: true)) {
    _checkAuthStatus();
  }
  final AuthRepository _authRepository;
  final Ref _ref;

  Future<void> _checkAuthStatus() async {
    try {
      // Read directly from SharedPreferences to avoid provider timing issues
      final token = await UserPreferencesService.getToken();
      final userData = await UserPreferencesService.getUserData();
      final isLoggedIn = await UserPreferencesService.isLoggedIn();

      logger.info('Auth Check - Token: ${token != null ? "exists" : "null"}');
      logger.info(
        'Auth Check - UserData: ${userData != null ? "exists" : "null"}',
      );
      logger.info('Auth Check - IsLoggedIn: $isLoggedIn');

      if (token != null && token.isNotEmpty && userData != null && isLoggedIn) {
        // Update the providers with the loaded data
        await _ref.read(authTokenProvider.notifier).setToken(token);
        await _ref.read(userDataProvider.notifier).setUserData(userData);

        state = state.copyWith(
          customer: userData,
          isAuthenticated: true,
          isLoading: false,
        );
        logger.info('Auth Check - User is authenticated');
      } else if (token != null && token.isNotEmpty) {
        // Token exists but no user data, try to fetch user info
        logger.info('Auth Check - Token exists but no user data, fetching...');
        await getMe();
      } else {
        // No token or user data, user is not authenticated
        logger.info('Auth Check - User is not authenticated');
        state = state.copyWith(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      // If there's an error, assume user is not authenticated
      logger.error('Auth Check - Error: $e');
      state = state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        error: 'Failed to check authentication status',
      );
    }
  //}

  // Future<void> register({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   state = state.copyWith(isLoading: true);

  //   final result = await _authRepository.register(
  //     name: name,
  //     email: email,
  //     password: password,
  //   );

    // if (result.isSuccess) {
    //   // Ensure registration data is saved to SharedPreferences
    //   await UserPreferencesService.saveUserData(result.customer!);
    //   await UserPreferencesService.saveToken(result.token!);

    //   // Update the providers
    //   await _ref.read(authTokenProvider.notifier).setToken(result.token!);
    //   await _ref.read(userDataProvider.notifier).setUserData(result.customer!);

    //   state = state.copyWith(
    //     isLoading: false,
    //     customer: result.customer,
    //     isAuthenticated: true,
    //   );
    // } else {
    //   state = state.copyWith(isLoading: false, error: result.error);
    // }
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true);

    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    if (result.isSuccess) {
      // Ensure login status is saved to SharedPreferences
      await UserPreferencesService.saveUserData(result.customer!);
      await UserPreferencesService.saveToken(result.token!);

      // Update the providers
      await _ref.read(authTokenProvider.notifier).setToken(result.token!);
      await _ref.read(userDataProvider.notifier).setUserData(result.customer!);

      state = state.copyWith(
        isLoading: false,
        customer: result.customer,
        isAuthenticated: true,
      );
    } else {
      state = state.copyWith(isLoading: false, error: result.error);
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    final result = await _authRepository.logout();

    if (result.isSuccess) {
      // Clear all local data
      await UserPreferencesService.clearUserData();

      // Clear the providers
      _ref.read(authTokenProvider.notifier).clearToken();
      _ref.read(userDataProvider.notifier).clearUserData();

      state = AuthState();
    } else {
      state = state.copyWith(isLoading: false, error: result.error);
    }
  }

  Future<void> logoutAll() async {
    state = state.copyWith(isLoading: true);

    final result = await _authRepository.logoutAll();

    if (result.isSuccess) {
      // Clear all local data
      await UserPreferencesService.clearUserData();

      // Clear the providers
      await _ref.read(authTokenProvider.notifier).clearToken();
      await _ref.read(userDataProvider.notifier).clearUserData();

      state = AuthState();
    } else {
      state = state.copyWith(isLoading: false, error: result.error);
    }
  }

  Future<void> getMe() async {
    final result = await _authRepository.getMe();

    if (result.isSuccess) {
      // Save the user data to preferences
      await UserPreferencesService.saveUserData(result.customer!);

      // Update the providers
      await _ref.read(userDataProvider.notifier).setUserData(result.customer!);

      state = state.copyWith(
        isLoading: false,
        customer: result.customer,
        isAuthenticated: true,
      );
    } else {
      // If getMe fails, clear any stored data and mark as unauthenticated
      await UserPreferencesService.clearUserData();

      // Clear the providers
      _ref.read(authTokenProvider.notifier).clearToken();
      _ref.read(userDataProvider.notifier).clearUserData();

      state = state.copyWith(
        isLoading: false,
        error: result.error,
        isAuthenticated: false,
      );
    }
  }

  void clearError() {
    state = state.copyWith();
  }
}

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.read(authRepositoryProvider), ref),
);
