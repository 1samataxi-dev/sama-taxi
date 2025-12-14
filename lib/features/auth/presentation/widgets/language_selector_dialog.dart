import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/widgets/index.dart';

class LanguageSelectorDialog extends StatelessWidget {
  const LanguageSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) => ScaleAnimation(
      begin: 0.8,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          AppStrings.language.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StaggeredListAnimation(
              children: [
                _LanguageTile(
                  title: AppStrings.arabic.tr(),
                  subtitle: 'العربية',
                  locale: const Locale('ar'),
                  isSelected: context.locale.languageCode == 'ar',
                ),
                const SizedBox(height: 8),
                _LanguageTile(
                  title: AppStrings.english.tr(),
                  subtitle: 'English',
                  locale: const Locale('en'),
                  isSelected: context.locale.languageCode == 'en',
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.title,
    required this.subtitle,
    required this.locale,
    required this.isSelected,
  });

  final String title;
  final String subtitle;
  final Locale locale;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected
            ? theme.primaryColor.withOpacity(0.1)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? theme.primaryColor.withOpacity(0.5)
              : theme.colorScheme.outline.withOpacity(0.2),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: isSelected
            ? Icon(Icons.check_circle, color: theme.primaryColor)
            : Icon(
                Icons.language,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? theme.primaryColor : null,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isSelected
                ? theme.primaryColor.withOpacity(0.8)
                : theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        onTap: () {
          context.setLocale(locale);
          Navigator.of(context).pop();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
