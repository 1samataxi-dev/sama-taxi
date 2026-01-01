import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/features/settings/presentation/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final notifier = ref.read(settingsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('App Settings', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Notifications tile
                  _SettingsTile(
                    leading: const Icon(Icons.notifications_none, color: Colors.black87),
                    title: 'Notifications',
                    subtitle: null,
                    trailing: Switch(
                      value: settings.notificationsEnabled,
                      onChanged: (_) => notifier.toggleNotifications(),
                    ),
                    onTap: null,
                  ),
                  const Divider(height: 1),
                  // Change Currency
                  _SettingsTile(
                    leading: const Icon(Icons.attach_money_outlined, color: Colors.black87),
                    title: 'Change Currency',
                    subtitle: settings.currency,
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () async {
                      final picked = await showModalBottomSheet<String>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        builder: (ctx) => _SelectionSheet(
                          title: 'Select Currency',
                          options: const ['US dollar', 'EUR', 'SAR'],
                          selected: settings.currency,
                        ),
                      );
                      if (picked != null) notifier.setCurrency(picked);
                    },
                  ),
                  const Divider(height: 1),
                  // Change Language
                  _SettingsTile(
                    leading: const Icon(Icons.language, color: Colors.black87),
                    title: 'Change Language',
                    subtitle: settings.language,
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () async {
                      final picked = await showModalBottomSheet<String>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        builder: (ctx) => _SelectionSheet(
                          title: 'Select Language',
                          options: const ['English', 'Arabic'],
                          selected: settings.language,
                        ),
                      );
                      if (picked != null) notifier.setLanguage(picked);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(child: leading),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(subtitle!, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    ]
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selected;

  const _SelectionSheet({required this.title, required this.options, required this.selected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            ...options.map((o) => ListTile(
                  title: Text(o),
                  trailing: o == selected ? const Icon(Icons.check, color: Colors.black) : null,
                  onTap: () => Navigator.of(context).pop(o),
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
