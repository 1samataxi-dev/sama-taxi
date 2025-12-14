import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/features/home/presentation/widgets/language_tile.dart';

void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        AppStrings.language.tr(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LanguageTile(
            title: AppStrings.arabic.tr(),
            subtitle: 'العربية',
            onTap: () {
              context.setLocale(const Locale('ar'));
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 8),
          LanguageTile(
            title: AppStrings.english.tr(),
            subtitle: 'English',
            onTap: () {
              context.setLocale(const Locale('en'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
