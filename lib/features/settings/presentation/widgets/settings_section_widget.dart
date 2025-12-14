import 'package:flutter/material.dart';
import 'package:sama_taxi/core/constants/app_colors.dart';
import 'package:sama_taxi/core/constants/app_typography.dart';
import 'package:sama_taxi/features/settings/domain/models/models.dart';
import 'package:sama_taxi/features/settings/presentation/widgets/settings_item_widget.dart';

class SettingsSectionWidget extends StatelessWidget {

  const SettingsSectionWidget({super.key, required this.section});
  final SettingsSection section;

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            section.title,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: section.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == section.items.length - 1;

              return Column(
                children: [
                  SettingsItemWidget(item: item),
                  if (!isLast)
                    Divider(
                      height: 1,
                      indent: 56,
                      color: AppColors.border.withValues(alpha: 0.3),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
}
