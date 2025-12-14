import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {

  const HomeBody({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ColoredBox(
      color: isDark ? const Color(0xFF111827) : const Color(0xFFF9FAFB),
      child: child,
    );
  }
}
