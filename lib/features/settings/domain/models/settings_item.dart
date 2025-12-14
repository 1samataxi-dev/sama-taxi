import 'package:flutter/material.dart';

enum SettingsItemType { navigation, toggle, action, info }

class SettingsItem {

  const SettingsItem({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.type,
    this.onTap,
    this.value,
    this.onToggle,
    this.iconColor,
    this.backgroundColor,
  });
  final String title;
  final String? subtitle;
  final IconData icon;
  final SettingsItemType type;
  final VoidCallback? onTap;
  final bool? value;
  final Function(bool)? onToggle;
  final Color? iconColor;
  final Color? backgroundColor;
}

class SettingsSection {

  const SettingsSection({required this.title, required this.items});
  final String title;
  final List<SettingsItem> items;
}
