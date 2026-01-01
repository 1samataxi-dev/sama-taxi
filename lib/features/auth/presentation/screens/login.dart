// lib/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/assets/app_assets.dart';
import 'package:sama_taxi/core/navigation/app_router.dart';

// ViewModel
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});

class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? error;

  LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.error,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  void updateEmail(String email) {
    state = state.copyWith(email: email, error: null);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, error: null);
  }

  Future<void> login(BuildContext context) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      state = state.copyWith(
        error: 'Please fill in all fields',
        isLoading: false,
      );
      return;
    }

    try {
      state = state.copyWith(isLoading: true, error: null);
      // TODO: Implement actual login logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      // Navigate to home on success
      // ignore: use_build_context_synchronously
     // context.goToVerifyOtp(email: state.email);
      // GoRouter.of(navigatorKey.currentContext!).go('/home');
    } catch (e) {
      state = state.copyWith(
        error: 'Login failed. Please try again.',
        isLoading: false,
      );
    }
  }
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Logo and Title
                Column(
                  children: [
                    Image.asset(
                      AppAssets.carLogo,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                   // const SizedBox(height: 16),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Error Message
                if (state.error != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[800]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.error!,
                            style: TextStyle(color: Colors.red[800]),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Email Field
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: notifier.updateEmail,
                ),
                const SizedBox(height: 16),

                // Password Field
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility_off_outlined),
                      onPressed: () {
                        // Toggle password visibility
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onChanged: notifier.updatePassword,
                ),
                const SizedBox(height: 8),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                    //  context.goToForgotPassword();
                      // Navigate to forgot password
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Button
                FilledButton(
                  onPressed: state.isLoading
                      ? null
                      : () async {
                          await notifier.login(context);
                        },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: state.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
                const SizedBox(height: 24),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                      //  context.goToSignUp();
                        // Navigate to sign up
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}