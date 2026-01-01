// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sama_taxi/core/constants/app_colors.dart';
// import 'package:sama_taxi/core/constants/app_typography.dart';
// import 'package:sama_taxi/core/localization/app_strings.dart';
// import 'package:sama_taxi/core/providers/theme_provider.dart';
// import 'package:sama_taxi/features/auth/presentation/auth_viewmodel.dart';
// import 'package:sama_taxi/features/settings/domain/models/models.dart';
// import 'package:sama_taxi/features/settings/presentation/widgets/widgets.dart';

// class SettingsScreen extends ConsumerWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeMode = ref.watch(themeModeProvider);
//     final authState = ref.watch(authViewModelProvider);
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             pinned: true,
//             backgroundColor: AppColors.primary,
//             flexibleSpace: FlexibleSpaceBar(
//               background: const SettingsHeader(),
//               title: Text(
//                 AppStrings.settings.tr(),
//                 style: AppTypography.titleLarge.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate([
//               const SizedBox(height: 8),

//               // Account Section
//               SettingsSectionWidget(
//                 section: SettingsSection(
//                   title: 'Account',
//                   items: [
//                     SettingsItem(
//                       title: 'Profile',
//                       subtitle: 'Edit your personal information',
//                       icon: Icons.person_outline,
//                       type: SettingsItemType.navigation,
//                       onTap: () => _navigateToProfile(context),
//                     ),
//                     SettingsItem(
//                       title: 'Bookings History',
//                       subtitle: 'View your past bookings',
//                       icon: Icons.history,
//                       type: SettingsItemType.navigation,
//                       onTap: () => _navigateToBookingsHistory(context),
//                     ),
//                     SettingsItem(
//                       title: 'Favorites',
//                       subtitle: 'Your saved hotels and tours',
//                       icon: Icons.favorite_outline,
//                       type: SettingsItemType.navigation,
//                       iconColor: Colors.red,
//                       onTap: () => _navigateToFavorites(context),
//                     ),
//                   ],
//                 ),
//               ),

//               // Preferences Section
//               SettingsSectionWidget(
//                 section: SettingsSection(
//                   title: 'Preferences',
//                   items: [
//                     SettingsItem(
//                       title: 'Dark Mode',
//                       subtitle: 'Switch between light and dark theme',
//                       icon: isDark ? Icons.dark_mode : Icons.light_mode,
//                       type: SettingsItemType.toggle,
//                       value: themeMode == ThemeMode.dark,
//                       onToggle: (value) {
//                         ref.read(themeModeProvider.notifier).toggleTheme();
//                       },
//                       iconColor: isDark ? Colors.purple : Colors.orange,
//                     ),
//                     SettingsItem(
//                       title: 'Language',
//                       subtitle: context.locale.languageCode == 'ar'
//                           ? 'العربية'
//                           : 'English',
//                       icon: Icons.language,
//                       type: SettingsItemType.navigation,
//                       iconColor: Colors.blue,
//                       onTap: () => _showLanguageDialog(context),
//                     ),
//                     SettingsItem(
//                       title: 'Notifications',
//                       subtitle: 'Manage your notification preferences',
//                       icon: Icons.notifications_none,
//                       type: SettingsItemType.navigation,
//                       iconColor: Colors.green,
//                       onTap: () => _navigateToNotifications(context),
//                     ),
//                     SettingsItem(
//                       title: 'Currency',
//                       subtitle: 'USD - US Dollar',
//                       icon: Icons.attach_money,
//                       type: SettingsItemType.navigation,
//                       iconColor: Colors.teal,
//                       onTap: () => _navigateToCurrency(context),
//                     ),
//                   ],
//                 ),
//               ),

//               // Support Section
//               SettingsSectionWidget(
//                 section: SettingsSection(
//                   title: 'Support',
//                   items: [
//                     SettingsItem(
//                       title: 'Help Center',
//                       subtitle: 'Get help and support',
//                       icon: Icons.help_outline,
//                       type: SettingsItemType.navigation,
//                       iconColor: Colors.indigo,
//                       onTap: () => _navigateToHelp(context),
//                     ),
//                     SettingsItem(
//                       title: 'Contact Us',
//                       subtitle: 'Reach out to our support team',
//                       icon: Icons.contact_support_outlined,
//                       type: SettingsItemType.navigation,
//                       iconColor: Colors.cyan,
//                       onTap: () => _navigateToContact(context),
//                     ),
//                     SettingsItem(
//                       title: 'Rate App',
//                       subtitle: 'Rate us on the app store',
//                       icon: Icons.star_outline,
//                       type: SettingsItemType.action,
//                       iconColor: Colors.amber,
//                       onTap: () => _rateApp(context),
//                     ),
//                     SettingsItem(
//                       title: 'Share App',
//                       subtitle: 'Share with friends and family',
//                       icon: Icons.share_outlined,
//                       type: SettingsItemType.action,
//                       iconColor: Colors.pink,
//                       onTap: () => _shareApp(context),
//                     ),
//                   ],
//                 ),
//               ),

//               // Legal Section
//               SettingsSectionWidget(
//                 section: SettingsSection(
//                   title: 'Legal',
//                   items: [
//                     SettingsItem(
//                       title: 'Privacy Policy',
//                       subtitle: 'Read our privacy policy',
//                       icon: Icons.privacy_tip_outlined,
//                       type: SettingsItemType.navigation,
//                       iconColor: Colors.deepPurple,
//                       onTap: () => _navigateToPrivacy(context),
//                     ),
//                     SettingsItem(
//                       title: 'Terms of Service',
//                       subtitle: 'Read our terms and conditions',
//                       icon: Icons.description_outlined,
//                       type: SettingsItemType.navigation,
//                       iconColor: Colors.brown,
//                       onTap: () => _navigateToTerms(context),
//                     ),
//                     SettingsItem(
//                       title: 'About',
//                       subtitle: 'Version 1.0.0',
//                       icon: Icons.info_outline,
//                       type: SettingsItemType.info,
//                       iconColor: Colors.grey,
//                       onTap: () => _showAboutDialog(context),
//                     ),
//                   ],
//                 ),
//               ),

//               // Account Actions Section
//               if (authState.isAuthenticated)
//                 SettingsSectionWidget(
//                   section: SettingsSection(
//                     title: 'Account Actions',
//                     items: [
//                       SettingsItem(
//                         title: 'Sign Out',
//                         subtitle: 'Sign out from your account',
//                         icon: Icons.logout,
//                         type: SettingsItemType.action,
//                         iconColor: Colors.red,
//                         onTap: () => _showSignOutDialog(context, ref),
//                       ),
//                     ],
//                   ),
//                 ),

//               const SizedBox(height: 32),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }

//   void _navigateToProfile(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Profile screen coming soon!')),
//     );
//   }

//   void _navigateToBookingsHistory(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Bookings history coming soon!')),
//     );
//   }

//   void _navigateToFavorites(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Favorites screen coming soon!')),
//     );
//   }

//   void _showLanguageDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => _LanguageDialog(currentLocale: context.locale),
//     );
//   }

//   void _navigateToNotifications(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Notifications settings coming soon!')),
//     );
//   }

//   void _navigateToCurrency(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Currency settings coming soon!')),
//     );
//   }

//   void _navigateToHelp(BuildContext context) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('Help center coming soon!')));
//   }

//   void _navigateToContact(BuildContext context) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('Contact us coming soon!')));
//   }

//   void _rateApp(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Rate app functionality coming soon!')),
//     );
//   }

//   void _shareApp(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Share app functionality coming soon!')),
//     );
//   }

//   void _navigateToPrivacy(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Privacy policy coming soon!')),
//     );
//   }

//   void _navigateToTerms(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Terms of service coming soon!')),
//     );
//   }

//   void _showAboutDialog(BuildContext context) {
//     showAboutDialog(
//       context: context,
//       applicationName: 'sama_taxi App',
//       applicationVersion: '1.0.0',
//       applicationIcon: Container(
//         width: 64,
//         height: 64,
//         decoration: BoxDecoration(
//           color: AppColors.primary,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: const Icon(Icons.flight_takeoff, color: Colors.white, size: 32),
//       ),
//       children: [
//         const Text(
//           'A modern sama_taxi management app built with Flutter.',
//           style: AppTypography.bodyMedium,
//         ),
//       ],
//     );
//   }

//   void _showSignOutDialog(BuildContext context, WidgetRef ref) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Text(
//           'Sign Out',
//           style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
//         ),
//         content: const Text(
//           'Are you sure you want to sign out?',
//           style: AppTypography.bodyMedium,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text(
//               'Cancel',
//               style: TextStyle(color: AppColors.textSecondary),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               ref.read(authViewModelProvider.notifier).logout();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Sign Out'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Language selection dialog
// class _LanguageDialog extends StatelessWidget {
//   const _LanguageDialog({required this.currentLocale});

//   final Locale currentLocale;

//   @override
//   Widget build(BuildContext context) => AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       title: Text(
//         AppStrings.language.tr(),
//         style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _LanguageOption(
//             title: 'English',
//             subtitle: 'English',
//             isSelected: currentLocale.languageCode == 'en',
//             onTap: () {
//               context.setLocale(const Locale('en'));
//               Navigator.pop(context);
//             },
//           ),
//           const SizedBox(height: 8),
//           _LanguageOption(
//             title: 'العربية',
//             subtitle: 'Arabic',
//             isSelected: currentLocale.languageCode == 'ar',
//             onTap: () {
//               context.setLocale(const Locale('ar'));
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
// }

// /// Language option tile
// class _LanguageOption extends StatelessWidget {
//   const _LanguageOption({
//     required this.title,
//     required this.subtitle,
//     required this.isSelected,
//     required this.onTap,
//   });

//   final String title;
//   final String subtitle;
//   final bool isSelected;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) => DecoratedBox(
//       decoration: BoxDecoration(
//         color: isSelected
//             ? AppColors.primary.withValues(alpha: 0.1)
//             : AppColors.surface,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isSelected
//               ? AppColors.primary
//               : AppColors.border.withValues(alpha: 0.3),
//         ),
//       ),
//       child: ListTile(
//         title: Text(
//           title,
//           style: AppTypography.bodyLarge.copyWith(
//             fontWeight: FontWeight.w500,
//             color: isSelected ? AppColors.primary : null,
//           ),
//         ),
//         subtitle: Text(
//           subtitle,
//           style: AppTypography.bodySmall.copyWith(
//             color: isSelected
//                 ? AppColors.primary.withValues(alpha: 0.7)
//                 : AppColors.textSecondary,
//           ),
//         ),
//         trailing: isSelected
//             ? const Icon(Icons.check_circle, color: AppColors.primary)
//             : null,
//         onTap: onTap,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
// }
