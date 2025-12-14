import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/constants/app_icons.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/widgets/index.dart';
import 'package:sama_taxi/features/auth/domain/auth_state.dart';
import 'package:sama_taxi/features/auth/presentation/auth_viewmodel.dart';

class OptimizedLoginForm extends ConsumerStatefulWidget {
  const OptimizedLoginForm({super.key});

  @override
  ConsumerState<OptimizedLoginForm> createState() => _OptimizedLoginFormState();
}

class _OptimizedLoginFormState extends ConsumerState<OptimizedLoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeInAnimation(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Welcome Section
              const _WelcomeSection(),

              const SizedBox(height: 32),

              // Form Fields
              _LoginFormFields(
                emailController: _emailController,
                passwordController: _passwordController,
              ),

              const SizedBox(height: 32),

              // Submit Button
              _LoginSubmitButton(onPressed: _handleLogin),
            ],
          ),
        ),
      ),
    );

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authViewModelProvider.notifier)
          .login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SlideInAnimation(
      delay: const Duration(milliseconds: 100),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          // gradient: isDark
          //     ? AppTheme.cardGradient(
          //         AppColors.neutral800,
          //         AppColors.neutral700,
          //       )
          //     : AppTheme.cardGradient(
          //         AppColors.surface,
          //         AppColors.surfaceVariant,
          //       ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildWelcomeIcon(theme),
            const SizedBox(height: 16),
            _buildWelcomeTitle(theme),
            const SizedBox(height: 8),
            _buildWelcomeSubtitle(theme, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeIcon(ThemeData theme) => Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        // gradient: AppTheme.primaryGradient,
        shape: BoxShape.circle,
      ),
      child: AppIcons.profileIcon(color: Colors.white, size: 32),
    );

  Widget _buildWelcomeTitle(ThemeData theme) => Text(
      AppStrings.login.tr(),
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );

  Widget _buildWelcomeSubtitle(ThemeData theme, bool isDark) => Text(
      AppStrings.welcome.tr(),
      style: theme.textTheme.bodyMedium?.copyWith(
        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
      ),
    );
}

class _LoginFormFields extends StatelessWidget {
  const _LoginFormFields({
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // Email Field
        SlideInAnimation(
          delay: const Duration(milliseconds: 200),
          child: CustomTextFormField(
            controller: emailController,
            labelText: AppStrings.email.tr(),
            hintText: 'Enter your email address',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: AppIcons.icon(
                AppIcons.profile,
                size: 20,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
        ),

        const SizedBox(height: 20),

        // Password Field
        SlideInAnimation(
          delay: const Duration(milliseconds: 400),
          child: CustomTextFormField(
            controller: passwordController,
            labelText: AppStrings.password.tr(),
            hintText: 'Enter your password',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: AppIcons.icon(
                AppIcons.settings,
                size: 20,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
            obscureText: true,
            validator: _validatePassword,
          ),
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired.tr();
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return AppStrings.emailInvalid.tr();
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired.tr();
    }
    if (value.length < 8) {
      return AppStrings.passwordMinLength.tr();
    }
    return null;
  }
}

class _LoginSubmitButton extends ConsumerWidget {
  const _LoginSubmitButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    // Listen for auth state changes
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      _handleAuthStateChange(context, ref, next);
    });

    return SlideInAnimation(
      delay: const Duration(milliseconds: 600),
      child: CustomButton(
        text: AppStrings.login.tr(),
        onPressed: authState.isLoading ? null : onPressed,
        size: ButtonSize.large,
        isLoading: authState.isLoading,
        fullWidth: true,
        elevation: 8,
      ),
    );
  }

  void _handleAuthStateChange(
    BuildContext context,
    WidgetRef ref,
    AuthState authState,
  ) {
    if (authState.error != null) {
      _showErrorSnackBar(context, authState.error!);
      ref.read(authViewModelProvider.notifier).clearError();
    }

    if (authState.isAuthenticated &&
        authState.customer != null &&
        !authState.isLoading) {
      _showSuccessSnackBar(context, authState.customer!.fullname);
    }
  }

  void _showErrorSnackBar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String userName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Welcome back, $userName!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
