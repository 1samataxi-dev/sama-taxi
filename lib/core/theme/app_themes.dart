import 'package:flutter/material.dart';
import 'package:sama_taxi/core/theme/arabic_fonts.dart';

class AppThemes {
  static ThemeData lightTheme() {
    const ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFD32F2F), // Red primary
      onPrimary: Color(0xFFFFFFFF), // White text on red
      primaryContainer: Color(0xFFFFEBEE), // Light red container
      onPrimaryContainer: Color(0xFF1A1A1A), // Dark text on light red
      secondary: Color(0xFFB71C1C), // Dark red secondary
      onSecondary: Color(0xFFFFFFFF), // White text on dark red
      secondaryContainer: Color(0xFFFFCDD2), // Light red secondary container
      onSecondaryContainer: Color(0xFF1A1A1A), // Dark text
      tertiary: Color(0xFF424242), // Gray tertiary
      onTertiary: Color(0xFFFFFFFF), // White text on gray
      error: Color(0xFFE53935), // Red error
      onError: Color(0xFFFFFFFF), // White text on error
      errorContainer: Color(0xFFFFEBEE), // Light red error container
      onErrorContainer: Color(0xFF1A1A1A), // Black text on background
      surface: Color(0xFFFFFFFF), // White surface
      onSurface: Color(0xFF1A1A1A), // Black text on surface
      surfaceContainerHighest: Color(0xFFF5F5F5), // Light gray surface variant
      onSurfaceVariant: Color(0xFF424242), // Dark gray text
      outline: Color(0xFFE0E0E0), // Light gray outline
      outlineVariant: Color(0xFFEEEEEE), // Very light gray outline
      shadow: Color(0xFF000000), // Black shadow
      scrim: Color(0xFF000000), // Black scrim
      inverseSurface: Color(0xFF1A1A1A), // Black inverse surface
      onInverseSurface: Color(0xFFFFFFFF), // White text on black
      inversePrimary: Color(0xFFFFB3BA), // Light red inverse primary
      surfaceTint: Color(0xFFD32F2F), // Red surface tint
    );

    return ThemeData(
      colorScheme: lightColorScheme,
      brightness: Brightness.light,
      // Modern Arabic font configuration - Using Tajawal
      textTheme: ArabicFonts.getTajawalTheme().apply(
        bodyColor: lightColorScheme.onSurface,
        displayColor: lightColorScheme.onSurface,
      ),
      // Primary text theme for consistency
      primaryTextTheme: ArabicFonts.getTajawalTheme().apply(
        bodyColor: lightColorScheme.onPrimary,
        displayColor: lightColorScheme.onPrimary,
      ),
      // App Bar theme
      appBarTheme: AppBarTheme(
        titleTextStyle: ArabicFonts.getAppBarStyle('tajawal').copyWith(
          color: lightColorScheme.onSurface,
        ),
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
        backgroundColor: lightColorScheme.surface,
        foregroundColor: lightColorScheme.onSurface,
        elevation: 0,
        iconTheme: IconThemeData(color: lightColorScheme.onSurface),
        actionsIconTheme: IconThemeData(color: lightColorScheme.onSurface),
      ),
      // Card theme
      cardTheme: CardThemeData(
        elevation: 2,
        color: lightColorScheme.surface,
        shadowColor: lightColorScheme.shadow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightColorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: lightColorScheme.primary, width: 2),
        ),
        labelStyle: ArabicFonts.getInputLabelStyle('tajawal').copyWith(
          color: lightColorScheme.onSurfaceVariant,
        ),
        hintStyle: TextStyle(color: lightColorScheme.onSurfaceVariant),
        filled: true,
        fillColor: lightColorScheme.surfaceContainerHighest,
      ),
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: ArabicFonts.getButtonTextStyle('tajawal'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          elevation: 2,
        ),
      ),
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightColorScheme.primary,
          textStyle: ArabicFonts.getButtonTextStyle('tajawal'),
        ),
      ),
      // Icon theme
      iconTheme: IconThemeData(
        color: lightColorScheme.onSurface,
        size: 24,
      ),
      // Primary icon theme
      primaryIconTheme: IconThemeData(
        color: lightColorScheme.primary,
        size: 24,
      ),
      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: lightColorScheme.surfaceContainerHighest,
        selectedColor: lightColorScheme.primary,
        deleteIconColor: lightColorScheme.onSurfaceVariant,
        labelStyle: TextStyle(color: lightColorScheme.onSurfaceVariant),
        secondarySelectedColor: lightColorScheme.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightColorScheme.surface,
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: lightColorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
      ),
      // Drawer theme
      drawerTheme: DrawerThemeData(
        backgroundColor: lightColorScheme.surface,
        scrimColor: lightColorScheme.scrim.withOpacity(0.5),
      ),
      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: lightColorScheme.surface,
        titleTextStyle: ArabicFonts.getAppBarStyle('tajawal').copyWith(
          color: lightColorScheme.onSurface,
          fontSize: 20,
        ),
        contentTextStyle: TextStyle(
          color: lightColorScheme.onSurface,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      // Scaffold background
      scaffoldBackgroundColor: lightColorScheme.surface,
      // Canvas color
      canvasColor: lightColorScheme.surface,
      // Divider color
      dividerColor: lightColorScheme.outline,
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme() {
    const ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFEF5350), // Bright red primary for dark mode
      onPrimary: Color(0xFF000000), // Black text on red
      primaryContainer: Color(0xFFB71C1C), // Dark red container
      onPrimaryContainer: Color(0xFFFFFFFF), // White text on dark red
      secondary: Color(0xFFFF5722), // Red-orange secondary
      onSecondary: Color(0xFF000000), // Black text on secondary
      secondaryContainer: Color(0xFFD84315), // Dark orange container
      onSecondaryContainer: Color(0xFFFFFFFF), // White text
      tertiary: Color(0xFF616161), // Medium gray tertiary
      onTertiary: Color(0xFFFFFFFF), // White text on gray
      error: Color(0xFFFF5252), // Bright red error
      onError: Color(0xFF000000), // Black text on error
      errorContainer: Color(0xFFD32F2F), // Red error container
      onErrorContainer: Color(0xFFFFFFFF), // White text on black
      surface: Color(0xFF121212), // Very dark gray surface
      onSurface: Color(0xFFFFFFFF), // White text on surface
      surfaceContainerHighest: Color(0xFF1E1E1E), // Dark gray surface variant
      onSurfaceVariant: Color(0xFFE0E0E0), // Light gray text
      outline: Color(0xFF424242), // Dark gray outline
      outlineVariant: Color(0xFF2E2E2E), // Very dark gray outline
      shadow: Color(0xFF000000), // Black shadow
      scrim: Color(0xFF000000), // Black scrim
      inverseSurface: Color(0xFFFFFFFF), // White inverse surface
      onInverseSurface: Color(0xFF000000), // Black text on white
      inversePrimary: Color(0xFFD32F2F), // Red inverse primary
      surfaceTint: Color(0xFFEF5350), // Bright red surface tint
    );

    return ThemeData(
      colorScheme: darkColorScheme,
      brightness: Brightness.dark,
      // Modern Arabic font configuration - Using Tajawal
      textTheme: ArabicFonts.getTajawalTheme().apply(
        bodyColor: darkColorScheme.onSurface,
        displayColor: darkColorScheme.onSurface,
      ),
      // Primary text theme for consistency
      primaryTextTheme: ArabicFonts.getTajawalTheme().apply(
        bodyColor: darkColorScheme.onPrimary,
        displayColor: darkColorScheme.onPrimary,
      ),
      // App Bar theme
      appBarTheme: AppBarTheme(
        titleTextStyle: ArabicFonts.getAppBarStyle('tajawal').copyWith(
          color: darkColorScheme.onSurface,
        ),
        backgroundColor: darkColorScheme.surface,
        foregroundColor: darkColorScheme.onSurface,
        elevation: 0,
        iconTheme: IconThemeData(color: darkColorScheme.onSurface),
        actionsIconTheme: IconThemeData(color: darkColorScheme.onSurface),
      ),
      // Card theme
      cardTheme: CardThemeData(
        elevation: 2,
        color: darkColorScheme.surface,
        shadowColor: darkColorScheme.shadow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkColorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
        ),
        labelStyle: ArabicFonts.getInputLabelStyle('tajawal').copyWith(
          color: darkColorScheme.onSurfaceVariant,
        ),
        hintStyle: TextStyle(color: darkColorScheme.onSurfaceVariant),
        filled: true,
        fillColor: darkColorScheme.surfaceContainerHighest,
      ),
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: ArabicFonts.getButtonTextStyle('tajawal'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          elevation: 2,
        ),
      ),
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkColorScheme.primary,
          textStyle: ArabicFonts.getButtonTextStyle('tajawal'),
        ),
      ),
      // Icon theme
      iconTheme: IconThemeData(
        color: darkColorScheme.onSurface,
        size: 24,
      ),
      // Primary icon theme
      primaryIconTheme: IconThemeData(
        color: darkColorScheme.primary,
        size: 24,
      ),
      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: darkColorScheme.surfaceContainerHighest,
        selectedColor: darkColorScheme.primary,
        deleteIconColor: darkColorScheme.onSurfaceVariant,
        labelStyle: TextStyle(color: darkColorScheme.onSurfaceVariant),
        secondarySelectedColor: darkColorScheme.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkColorScheme.surface,
        selectedItemColor: darkColorScheme.primary,
        unselectedItemColor: darkColorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
      ),
      // Drawer theme
      drawerTheme: DrawerThemeData(
        backgroundColor: darkColorScheme.surface,
        scrimColor: darkColorScheme.scrim.withOpacity(0.5),
      ),
      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: darkColorScheme.surface,
        titleTextStyle: ArabicFonts.getAppBarStyle('tajawal').copyWith(
          color: darkColorScheme.onSurface,
          fontSize: 20,
        ),
        contentTextStyle: TextStyle(
          color: darkColorScheme.onSurface,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      // Scaffold background
      scaffoldBackgroundColor: darkColorScheme.surface,
      // Canvas color
      canvasColor: darkColorScheme.surface,
      // Divider color
      dividerColor: darkColorScheme.outline,
      useMaterial3: true,
    );
  }
}
