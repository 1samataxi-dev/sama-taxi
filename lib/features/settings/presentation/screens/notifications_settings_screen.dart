import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sama_taxi/core/constants/app_colors.dart';
import 'package:sama_taxi/features/settings/domain/models/models.dart';
import 'package:sama_taxi/features/settings/presentation/widgets/widgets.dart';

class NotificationsSettingsScreen extends ConsumerStatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  ConsumerState<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends ConsumerState<NotificationsSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _bookingUpdates = true;
  bool _promotionalOffers = false;
  bool _sama_taxiReminders = true;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            SettingsSectionWidget(
              section: SettingsSection(
                title: 'General',
                items: [
                  SettingsItem(
                    title: 'Push Notifications',
                    subtitle: 'Receive notifications on your device',
                    icon: Icons.notifications_active,
                    type: SettingsItemType.toggle,
                    value: _pushNotifications,
                    onToggle: (value) {
                      setState(() {
                        _pushNotifications = value;
                      });
                    },
                  ),
                  SettingsItem(
                    title: 'Email Notifications',
                    subtitle: 'Receive notifications via email',
                    icon: Icons.email_outlined,
                    type: SettingsItemType.toggle,
                    value: _emailNotifications,
                    onToggle: (value) {
                      setState(() {
                        _emailNotifications = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            SettingsSectionWidget(
              section: SettingsSection(
                title: 'sama_taxi Updates',
                items: [
                  SettingsItem(
                    title: 'Booking Updates',
                    subtitle:
                        'Get notified about booking confirmations and changes',
                    icon: Icons.book_online,
                    type: SettingsItemType.toggle,
                    value: _bookingUpdates,
                    iconColor: Colors.blue,
                    onToggle: (value) {
                      setState(() {
                        _bookingUpdates = value;
                      });
                    },
                  ),
                  SettingsItem(
                    title: 'sama_taxi Reminders',
                    subtitle: 'Reminders about upcoming trips',
                    icon: Icons.schedule,
                    type: SettingsItemType.toggle,
                    value: _sama_taxiReminders,
                    iconColor: Colors.orange,
                    onToggle: (value) {
                      setState(() {
                        _sama_taxiReminders = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            SettingsSectionWidget(
              section: SettingsSection(
                title: 'Marketing',
                items: [
                  SettingsItem(
                    title: 'Promotional Offers',
                    subtitle: 'Receive special deals and discounts',
                    icon: Icons.local_offer,
                    type: SettingsItemType.toggle,
                    value: _promotionalOffers,
                    iconColor: Colors.green,
                    onToggle: (value) {
                      setState(() {
                        _promotionalOffers = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
}
