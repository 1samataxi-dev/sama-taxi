// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:rased_integrations/core/constants/app_icons.dart';
// import 'package:rased_integrations/core/localization/app_strings.dart';
// import 'package:rased_integrations/features/auth/domain/auth_state.dart';
// import 'package:rased_integrations/features/auth/presentation/auth_viewmodel.dart';

// class RegisterForm extends ConsumerStatefulWidget {
//   const RegisterForm({super.key});

//   @override
//   ConsumerState<RegisterForm> createState() => _RegisterFormState();
// }

// class _RegisterFormState extends ConsumerState<RegisterForm>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _obscurePassword = true;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authViewModelProvider);
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     ref.listen<AuthState>(authViewModelProvider, (previous, next) {
//       if (next.error != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(next.error!),
//             backgroundColor: Theme.of(context).colorScheme.error,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         );
//         ref.read(authViewModelProvider.notifier).clearError();
//       }

//       // Navigate to home page on successful registration
//       if (next.isAuthenticated && next.customer != null && !next.isLoading) {
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Welcome, ${next.customer!.name}! Account created successfully.',
//             ),
//             backgroundColor: Colors.green,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         );

//         // The main.dart will automatically navigate to HomeScreen
//         // because it watches authViewModelProvider.isAuthenticated
//       }
//     });

//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(32),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 40),

//               // Welcome Section
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   // gradient: isDark
//                   //     ? AppTheme.cardGradient(
//                   //         AppColors.neutral800,
//                   //         AppColors.neutral700,
//                   //       )
//                   //     : AppTheme.cardGradient(
//                   //         AppColors.surface,
//                   //         AppColors.surfaceVariant,
//                   //       ),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       offset: const Offset(0, 8),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: const BoxDecoration(
//                         // gradient: AppTheme.accentGradient,
//                         shape: BoxShape.circle,
//                       ),
//                       child: AppIcons.profileIcon(
//                         color: Colors.white,
//                         size: 32,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       AppStrings.register.tr(),
//                       style: Theme.of(context).textTheme.headlineSmall
//                           ?.copyWith(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Create your account',
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                         color: isDark
//                             ? Colors.grey.shade400
//                             : Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 32),

//               // Name Field
//               _ModernTextField(
//                 controller: _nameController,
//                 labelText: AppStrings.name.tr(),
//                 prefixIcon: Icons.person_outline,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppStrings.nameRequired.tr();
//                   }
//                   return null;
//                 },
//               ),

//               const SizedBox(height: 20),

//               // Email Field
//               _ModernTextField(
//                 controller: _emailController,
//                 labelText: AppStrings.email.tr(),
//                 prefixIcon: Icons.email_outlined,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppStrings.emailRequired.tr();
//                   }
//                   if (!RegExp(
//                     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                   ).hasMatch(value)) {
//                     return AppStrings.emailInvalid.tr();
//                   }
//                   return null;
//                 },
//               ),

//               const SizedBox(height: 20),

//               // Password Field
//               _ModernTextField(
//                 controller: _passwordController,
//                 labelText: AppStrings.password.tr(),
//                 prefixIcon: Icons.lock_outline,
//                 obscureText: _obscurePassword,
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _obscurePassword
//                         ? Icons.visibility_outlined
//                         : Icons.visibility_off_outlined,
//                     size: 20,
//                     color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _obscurePassword = !_obscurePassword;
//                     });
//                   },
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppStrings.passwordRequired.tr();
//                   }
//                   if (value.length < 8) {
//                     return AppStrings.passwordMinLength.tr();
//                   }
//                   return null;
//                 },
//               ),

//               const SizedBox(height: 32),

//               // Register Button
//               Container(
//                 height: 56,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: authState.isLoading
//                       ? null
//                       : [
//                           BoxShadow(
//                             color: Theme.of(
//                               context,
//                             ).colorScheme.primary.withOpacity(0.3),
//                             blurRadius: 12,
//                             offset: const Offset(0, 6),
//                           ),
//                         ],
//                 ),
//                 child: ElevatedButton(
//                   onPressed: authState.isLoading ? null : _register,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.primary,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   child: authState.isLoading
//                       ? const SizedBox(
//                           height: 24,
//                           width: 24,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               Colors.white,
//                             ),
//                           ),
//                         )
//                       : Text(
//                           AppStrings.register.tr(),
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _register() {
//     if (_formKey.currentState!.validate()) {
//       ref
//           .read(authViewModelProvider.notifier)
//           .register(
//             name: _nameController.text.trim(),
//             email: _emailController.text.trim(),
//             password: _passwordController.text,
//           );
//     }
//   }
// }

// class _ModernTextField extends StatelessWidget {
//   const _ModernTextField({
//     required this.controller,
//     required this.labelText,
//     this.prefixIconPath,
//     this.prefixIcon,
//     this.keyboardType,
//     this.obscureText = false,
//     this.suffixIcon,
//     this.validator,
//   }) : assert(
//          prefixIconPath != null || prefixIcon != null,
//          'Either prefixIconPath or prefixIcon must be provided',
//        );

//   final TextEditingController controller;
//   final String labelText;
//   final String? prefixIconPath;
//   final IconData? prefixIcon;
//   final TextInputType? keyboardType;
//   final bool obscureText;
//   final Widget? suffixIcon;
//   final String? Function(String?)? validator;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return DecoratedBox(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         obscureText: obscureText,
//         validator: validator,
//         style: TextStyle(
//           fontSize: 16,
//           color: isDark ? Colors.white : Colors.black87,
//         ),
//         decoration: InputDecoration(
//           labelText: labelText,
//           prefixIcon: Padding(
//             padding: const EdgeInsets.all(12),
//             child: prefixIcon != null
//                 ? Icon(
//                     prefixIcon,
//                     size: 20,
//                     color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
//                   )
//                 : AppIcons.icon(
//                     prefixIconPath!,
//                     size: 20,
//                     color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
//                   ),
//           ),
//           suffixIcon: suffixIcon,
//           labelStyle: TextStyle(
//             color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
//           ),
//           filled: true,
//           fillColor: isDark ? Colors.grey.shade800 : Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(
//               color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(
//               color: Theme.of(context).colorScheme.primary,
//               width: 2,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }
