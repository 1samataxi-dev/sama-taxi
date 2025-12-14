import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/constants/app_icons.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/providers/theme_provider.dart';
import 'package:sama_taxi/features/home/presentation/widgets/language_dialog.dart';
import 'package:sama_taxi/features/home/presentation/widgets/logout_dialogs.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {

  const HomeAppBar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          letterSpacing: -0.3,
          color: isDark ? Colors.white : const Color(0xFF111827),
        ),
      ),
      centerTitle: false,
      backgroundColor: isDark ? const Color(0xFF111827) : Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF374151) : const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB),
            ),
          ),
          child: PopupMenuButton<String>(
            icon: Container(
              padding: const EdgeInsets.all(8),
              child: AppIcons.menuIcon(
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: isDark ? const Color(0xFF374151) : Colors.white,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.black.withOpacity(0.1),
            elevation: 4,
            onSelected: (value) => _handleMenuSelection(value, context, ref),
            itemBuilder: (context) => [
              _buildPopupMenuItem(
                context,
                'theme',
                themeMode == ThemeMode.dark
                    ? AppIcons.settings
                    : AppIcons.settings,
                themeMode == ThemeMode.dark
                    ? AppStrings.light.tr()
                    : AppStrings.dark.tr(),
              ),
              _buildPopupMenuItem(
                context,
                'language',
                AppIcons.settings,
                AppStrings.language.tr(),
              ),
              const PopupMenuDivider(),
              _buildPopupMenuItem(
                context,
                'logout',
                AppIcons.arrowBack,
                AppStrings.logout.tr(),
              ),
              _buildPopupMenuItem(
                context,
                'logout_all',
                AppIcons.arrowBack,
                AppStrings.logoutAll.tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleMenuSelection(String value, BuildContext context, WidgetRef ref) {
    switch (value) {
      case 'theme':
        ref.read(themeModeProvider.notifier).toggleTheme();
        break;
      case 'language':
        showLanguageDialog(context);
        break;
      case 'logout':
        showLogoutDialog(context, ref);
        break;
      case 'logout_all':
        showLogoutAllDialog(context, ref);
        break;
    }
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    BuildContext context,
    String value,
    String iconPath,
    String text,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopupMenuItem(
      value: value,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
              ),
              child: AppIcons.icon(
                iconPath,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black87,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
