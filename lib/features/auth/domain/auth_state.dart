import 'package:sama_taxi/features/auth/domain/models/customer.dart';

class AuthState {

  AuthState({
    this.isLoading = false,
    this.customer,
    this.error,
    this.isAuthenticated = false,
  });
  final bool isLoading;
  final Customer? customer;
  final String? error;
  final bool isAuthenticated;

  AuthState copyWith({
    bool? isLoading,
    Customer? customer,
    String? error,
    bool? isAuthenticated,
  }) => AuthState(
      isLoading: isLoading ?? this.isLoading,
      customer: customer ?? this.customer,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
}
