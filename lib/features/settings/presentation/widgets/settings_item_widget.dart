import 'package:flutter/material.dart';
import 'package:sama_taxi/core/constants/app_colors.dart';
import 'package:sama_taxi/core/constants/app_typography.dart';
import 'package:sama_taxi/features/settings/domain/models/models.dart';

class SettingsItemWidget extends StatelessWidget {

  const SettingsItemWidget({super.key, required this.item});
  final SettingsItem item;

  @override
  Widget build(BuildContext context) => ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color:
              item.backgroundColor ??
              item.iconColor?.withValues(alpha: 0.1) ??
              AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          item.icon,
          color: item.iconColor ?? AppColors.primary,
          size: 22,
        ),
      ),
      title: Text(
        item.title,
        style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: item.subtitle != null
          ? Text(
              item.subtitle!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            )
          : null,
      trailing: _buildTrailing(),
      onTap: item.onTap,
    );

  Widget _buildTrailing() {
    switch (item.type) {
      case SettingsItemType.navigation:
        return const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
          size: 20,
        );

      case SettingsItemType.toggle:
        return Switch.adaptive(
          value: item.value ?? false,
          onChanged: item.onToggle,
          activeColor: AppColors.primary,
        );

      case SettingsItemType.action:
        return const Icon(Icons.launch, color: AppColors.textSecondary, size: 18);

      case SettingsItemType.info:
        return const SizedBox.shrink();
    }
  }
}
