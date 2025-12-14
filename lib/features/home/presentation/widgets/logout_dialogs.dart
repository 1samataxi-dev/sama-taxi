import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/features/auth/presentation/auth_viewmodel.dart';

void showLogoutDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        AppStrings.logout.tr(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text('${AppStrings.confirm.tr()}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.cancel.tr()),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            // gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authViewModelProvider.notifier).logout();
            },
            child: Text(
              AppStrings.confirm.tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

void showLogoutAllDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        AppStrings.logoutAll.tr(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text('${AppStrings.confirm.tr()}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.cancel.tr()),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            // gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authViewModelProvider.notifier).logoutAll();
            },
            child: Text(
              AppStrings.confirm.tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
