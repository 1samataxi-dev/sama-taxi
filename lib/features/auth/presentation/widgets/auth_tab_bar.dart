import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';
import 'package:sama_taxi/core/widgets/index.dart';

class AuthTabBar extends StatelessWidget {
  const AuthTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) => SlideInAnimation(
    begin: const Offset(0, 0.3),
    delay: const Duration(milliseconds: 500),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: _buildTabBarDecoration(context),
      child:   _AuthTab(text: AppStrings.login.tr(), icon: Icons.login),
    ),
  );

  BoxDecoration _buildTabBarDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BoxDecoration(
      color: isDark ? Colors.grey.shade800 : Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TabBar(
      controller: tabController,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      labelColor: Colors.white,
      unselectedLabelColor: isDark
          ? Colors.grey.shade400
          : Colors.grey.shade600,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      tabs: [
        _AuthTab(text: AppStrings.login.tr(), icon: Icons.login),
        _AuthTab(text: AppStrings.register.tr(), icon: Icons.person_add),
      ],
    );
  }
}

class _AuthTab extends StatelessWidget {
  const _AuthTab({required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Tab(
    height: 56,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(text)],
    ),
  );
}
