import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Helper class for accessibility features
class AccessibilityHelper {
  /// Minimum touch target size (44x44 logical pixels)
  static const double minTouchTargetSize = 44;

  /// Minimum contrast ratio for normal text (4.5:1)
  static const double minContrastRatio = 4.5;

  /// Minimum contrast ratio for large text (3:1)
  static const double minLargeTextContrastRatio = 3;

  /// Create accessible button with proper semantics
  static Widget accessibleButton({
    required Widget child,
    required VoidCallback? onPressed,
    String? semanticLabel,
    String? tooltip,
    EdgeInsetsGeometry? padding,
  }) => Semantics(
      label: semanticLabel,
      button: true,
      enabled: onPressed != null,
      child: Tooltip(
        message: tooltip ?? '',
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: minTouchTargetSize,
              minHeight: minTouchTargetSize,
            ),
            padding: padding ?? const EdgeInsets.all(12),
            child: child,
          ),
        ),
      ),
    );

  /// Create accessible text field with proper semantics
  static Widget accessibleTextField({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    String? errorText,
    String? semanticLabel,
    TextInputType? keyboardType,
    bool obscureText = false,
    ValueChanged<String>? onChanged,
  }) => Semantics(
      label: semanticLabel ?? labelText,
      textField: true,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
        ),
      ),
    );

  /// Create accessible card with proper semantics
  static Widget accessibleCard({
    required Widget child,
    String? semanticLabel,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
  }) => Semantics(
      label: semanticLabel,
      button: onTap != null,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );

  /// Create accessible image with proper semantics
  static Widget accessibleImage({
    required ImageProvider image,
    required String semanticLabel,
    double? width,
    double? height,
    BoxFit? fit,
  }) => Semantics(
      label: semanticLabel,
      image: true,
      child: Image(
        image: image,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
      ),
    );

  /// Create accessible icon with proper semantics
  static Widget accessibleIcon({
    required IconData icon,
    required String semanticLabel,
    Color? color,
    double? size,
  }) => Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: Icon(icon, color: color, size: size),
      ),
    );

  /// Create accessible list tile with proper semantics
  static Widget accessibleListTile({
    Widget? leading,
    required Widget title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    String? semanticLabel,
  }) => Semantics(
      label: semanticLabel,
      button: onTap != null,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
      ),
    );

  /// Announce message to screen readers
  static void announceToScreenReader(String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }

  /// Check if device has accessibility features enabled
  static bool hasAccessibilityFeatures(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.accessibleNavigation ||
        mediaQuery.boldText ||
        mediaQuery.highContrast ||
        mediaQuery.textScaler.scale(1) > 1.0;
  }

  /// Get scaled font size based on accessibility settings
  static double getScaledFontSize(BuildContext context, double baseFontSize) {
    final textScaler = MediaQuery.of(context).textScaler;
    return textScaler.scale(baseFontSize);
  }

  /// Create focus node with proper semantics
  static FocusNode createAccessibleFocusNode({
    String? debugLabel,
    bool skipTraversal = false,
  }) => FocusNode(debugLabel: debugLabel, skipTraversal: skipTraversal);

  /// Wrap widget with focus management
  static Widget withFocusManagement({
    required Widget child,
    FocusNode? focusNode,
    bool autofocus = false,
  }) => Focus(focusNode: focusNode, autofocus: autofocus, child: child);
}

/// Mixin for accessibility features in widgets
mixin AccessibilityMixin {
  /// Announce message to screen readers
  void announceMessage(String message) {
    AccessibilityHelper.announceToScreenReader(message);
  }

  /// Check if accessibility features are enabled
  bool hasAccessibilityFeatures(BuildContext context) => AccessibilityHelper.hasAccessibilityFeatures(context);

  /// Get scaled font size
  double getScaledFontSize(BuildContext context, double baseFontSize) => AccessibilityHelper.getScaledFontSize(context, baseFontSize);
}
