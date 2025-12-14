import 'package:flutter/material.dart';
import 'package:sama_taxi/features/settings/presentation/screens/screens.dart';
import 'package:sama_taxi/features/settings/presentation/settings_screen.dart';

/// Example of how to integrate the settings screen into your app
class SettingsIntegrationExample {
  /// Navigate to main settings screen
  static void navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  /// Navigate to notifications settings
  static void navigateToNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationsSettingsScreen(),
      ),
    );
  }

  /// Navigate to help center
  static void navigateToHelpCenter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
    );
  }

  /// Add settings button to app bar
  static Widget buildSettingsButton(BuildContext context) => IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => navigateToSettings(context),
      tooltip: 'Settings',
    );

  /// Add settings tile to drawer
  static Widget buildSettingsDrawerTile(BuildContext context) => ListTile(
      leading: const Icon(Icons.settings),
      title: const Text('Settings'),
      onTap: () {
        Navigator.pop(context); // Close drawer
        navigateToSettings(context);
      },
    );
}

/// Example usage in your main app
class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('sama_taxi App'),
        actions: [
          // Add settings button to app bar
          SettingsIntegrationExample.buildSettingsButton(context),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('sama_taxi App')),
            // Add settings tile to drawer
            SettingsIntegrationExample.buildSettingsDrawerTile(context),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              SettingsIntegrationExample.navigateToSettings(context),
          child: const Text('Open Settings'),
        ),
      ),
    );
}
