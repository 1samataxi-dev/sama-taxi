import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/providers/theme_provider.dart';
import 'package:sama_taxi/core/widgets/index.dart';
import 'package:sama_taxi/features/auth/domain/auth_state.dart';
import 'package:sama_taxi/features/auth/presentation/auth_viewmodel.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
  final authState = ref.watch(authViewModelProvider);
      final themeProvider = ref.watch(themeModeProvider);
    final isDarkMode = themeProvider;

  // -------------------- RIVERPOD LISTENER (UNCHANGED) --------------------
  ref.listen<AuthState>(authViewModelProvider, (previous, next) {
    if (next.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(next.error!),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      ref.read(authViewModelProvider.notifier).clearError();
    }

    if (next.isAuthenticated && next.customer != null && !next.isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome back, ${next.customer!.fullname}!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  });

  return Scaffold(
      body: Container(
        decoration: BoxDecoration(
         
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  
                  // Logo and title section
                  _buildHeader(),
                  
                  const SizedBox(height: 30),
                  
                  // Login form
                  _buildLoginForm(context, ),
                  
                  const SizedBox(height: 40),
                  
                  // Theme toggle and footer
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
}

// ---------------------------------------------------------------------------
// HEADER (SAME UI FROM CODE #1)
// ---------------------------------------------------------------------------
Widget _buildHeader() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(
          Icons.dashboard_rounded,
          size: 60,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 24),
      const Text(
        'راصد',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Text(
        'نظام إدارة السائقين والمركبات',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// LOGIN FORM (RIVERPOD LOGIC + UI FROM FIRST DESIGN)
// ---------------------------------------------------------------------------
Widget _buildLoginForm(BuildContext context, ) {
  return Container(
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 30,
          offset: const Offset(0, 15),
        ),
      ],
    ),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            'تسجيل الدخول',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // Email
          CustomTextFormField(
            controller: _emailController,
            labelText: "البريد الإلكتروني",
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (value) {
              if (value == null || value.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'يرجى إدخال بريد إلكتروني صحيح';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          // Password
          CustomTextFormField(
            controller: _passwordController,
            labelText: "كلمة المرور",
            prefixIcon: const Icon(Icons.lock_outline),
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'يرجى إدخال كلمة المرور';
              if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
              return null;
            },
          ),

          const SizedBox(height: 32),

          // Login Button
          CustomButton(
            isDisabled: false,
            text: "تسجيل الدخول",
             onPressed: (){

//if (_formKey.currentState!.validate())
 {
  
      ref
          .read(authViewModelProvider.notifier)
          .login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
       //   debugPrint("${_emailController.text.trim()} Try login to:");
    }
             },
            // onPressed: authState.isLoading ? null : _login,
           // isLoading: authState.isLoading,
            fullWidth: true,
            size: ButtonSize.large,
          )
        ],
      ),
    ),
  );
}
// void _login() {
//     if (_formKey.currentState!.validate()) {
//       ref
//           .read(authViewModelProvider.notifier)
//           .login(
//             email: _emailController.text.trim(),
//             password: _passwordController.text,
//           );
//     }
//   }
// ---------------------------------------------------------------------------
// FOOTER (FROM FIRST UI, LIGHT MOD)
// ---------------------------------------------------------------------------
Widget _buildFooter() {
  return Column(
    children: [
      const SizedBox(height: 24),
      Text(
        '© 2025 سما تاكسي - جميع الحقوق محفوظة',
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
    }

    