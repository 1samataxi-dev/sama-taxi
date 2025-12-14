import 'package:flutter/material.dart';
import 'package:sama_taxi/core/constants/app_colors.dart';
import 'package:sama_taxi/features/settings/domain/models/models.dart';
import 'package:sama_taxi/features/settings/presentation/widgets/widgets.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for help...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            SettingsSectionWidget(
              section: SettingsSection(
                title: 'Frequently Asked Questions',
                items: [
                  SettingsItem(
                    title: 'How to book a hotel?',
                    subtitle: 'Step-by-step guide for hotel booking',
                    icon: Icons.hotel,
                    type: SettingsItemType.navigation,
                    iconColor: Colors.blue,
                    onTap: () => _showFAQ(context, 'Hotel Booking Guide'),
                  ),
                  SettingsItem(
                    title: 'Cancellation policy',
                    subtitle: 'Learn about our cancellation terms',
                    icon: Icons.cancel_outlined,
                    type: SettingsItemType.navigation,
                    iconColor: Colors.red,
                    onTap: () => _showFAQ(context, 'Cancellation Policy'),
                  ),
                  SettingsItem(
                    title: 'Payment methods',
                    subtitle: 'Supported payment options',
                    icon: Icons.payment,
                    type: SettingsItemType.navigation,
                    iconColor: Colors.green,
                    onTap: () => _showFAQ(context, 'Payment Methods'),
                  ),
                  SettingsItem(
                    title: 'sama_taxi insurance',
                    subtitle: 'Information about sama_taxi insurance',
                    icon: Icons.security,
                    type: SettingsItemType.navigation,
                    iconColor: Colors.purple,
                    onTap: () => _showFAQ(context, 'sama_taxi Insurance'),
                  ),
                ],
              ),
            ),

            SettingsSectionWidget(
              section: SettingsSection(
                title: 'Contact Support',
                items: [
                  SettingsItem(
                    title: 'Live Chat',
                    subtitle: 'Chat with our support team',
                    icon: Icons.chat_bubble_outline,
                    type: SettingsItemType.navigation,
                    iconColor: Colors.teal,
                    onTap: () => _startLiveChat(context),
                  ),
                  SettingsItem(
                    title: 'Email Support',
                    subtitle: 'support@sama_taxiapp.com',
                    icon: Icons.email_outlined,
                    type: SettingsItemType.action,
                    iconColor: Colors.orange,
                    onTap: () => _sendEmail(context),
                  ),
                  SettingsItem(
                    title: 'Phone Support',
                    subtitle: '+1 (555) 123-4567',
                    icon: Icons.phone_outlined,
                    type: SettingsItemType.action,
                    iconColor: Colors.indigo,
                    onTap: () => _callSupport(context),
                  ),
                ],
              ),
            ),

            SettingsSectionWidget(
              section: SettingsSection(
                title: 'Resources',
                items: [
                  SettingsItem(
                    title: 'User Guide',
                    subtitle: 'Complete app user manual',
                    icon: Icons.menu_book,
                    type: SettingsItemType.navigation,
                    iconColor: Colors.brown,
                    onTap: () => _openUserGuide(context),
                  ),
                  SettingsItem(
                    title: 'Video Tutorials',
                    subtitle: 'Watch how-to videos',
                    icon: Icons.play_circle_outline,
                    type: SettingsItemType.navigation,
                    iconColor: Colors.red,
                    onTap: () => _openVideoTutorials(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );

  void _showFAQ(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(
          'This is a placeholder for the $title content. '
          'In a real app, this would show detailed information.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _startLiveChat(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Live chat feature coming soon!')),
    );
  }

  void _sendEmail(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opening email client...')));
  }

  void _callSupport(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opening phone dialer...')));
  }

  void _openUserGuide(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('User guide coming soon!')));
  }

  void _openVideoTutorials(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Video tutorials coming soon!')),
    );
  }
}
