import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/constants/app_icons.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/providers/theme_provider.dart';
import 'package:sama_taxi/core/widgets/index.dart';
import 'package:sama_taxi/features/auth/presentation/widgets/language_selector_dialog.dart';

class AuthHeader extends ConsumerWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => SlideInAnimation(
    begin: const Offset(0, -0.5),
    child: Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: _AppTitleSection()),
          _HeaderActions(
            onThemeToggle: () =>
                ref.read(themeModeProvider.notifier).toggleTheme(),
            onLanguageSelect: () => _showLanguageDialog(context),
          ),
        ],
      ),
    ),
  );

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LanguageSelectorDialog(),
    );
  }
}

class _AppTitleSection extends StatelessWidget {
  const _AppTitleSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInAnimation(
          delay: const Duration(milliseconds: 200),
          child: Text(
            AppStrings.appName.tr(),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 4),
        FadeInAnimation(
          delay: const Duration(milliseconds: 400),
          child: Text(
            AppStrings.welcome.tr(),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderActions extends StatelessWidget {
  const _HeaderActions({
    required this.onThemeToggle,
    required this.onLanguageSelect,
  });

  final VoidCallback onThemeToggle;
  final VoidCallback onLanguageSelect;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SlideInAnimation(
      begin: const Offset(0.5, 0),
      delay: const Duration(milliseconds: 300),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModernIconButton(
            icon: isDark ? Icons.light_mode : Icons.dark_mode,
            onPressed: onThemeToggle,
            tooltip: 'Toggle Theme',
          ),
          const SizedBox(width: 8),
          _ModernIconButton(
            icon: Icons.language,
            onPressed: onLanguageSelect,
            tooltip: 'Change Language',
          ),
        ],
      ),
    );
  }
}

class _ModernIconButton extends StatelessWidget {
  const _ModernIconButton({
    this.iconPath,
    this.icon,
    required this.onPressed,
    this.tooltip,
  }) : assert(
         iconPath != null || icon != null,
         'Either iconPath or icon must be provided',
       );

  final String? iconPath;
  final IconData? icon;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final button = DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: icon != null
            ? Icon(
                icon,
                color: isDark ? Colors.white : Colors.black87,
                size: 24,
              )
            : AppIcons.icon(
                iconPath!,
                color: isDark ? Colors.white : Colors.black87,
              ),
        onPressed: onPressed,
        splashRadius: 20,
      ),
    );

    return tooltip != null ? Tooltip(message: tooltip, child: button) : button;
  }
}
