import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sama_taxi/core/constants/app_colors.dart';
import 'package:sama_taxi/core/constants/app_typography.dart';

class AppTheme {
  // Modern glass morphism effect
  static BoxDecoration glassMorphism({
    Color? color,
    double blur = 10.0,
    double opacity = 0.1,
    BorderRadius? borderRadius,
  }) => BoxDecoration(
    color: (color ?? Colors.white).withValues(alpha: opacity),
    borderRadius: borderRadius ?? BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: blur,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Enhanced card decoration with modern shadows
  static BoxDecoration modernCard({
    Color? backgroundColor,
    BorderRadius? borderRadius,
    bool hasBorder = true,
    Color? borderColor,
  }) => BoxDecoration(
    color: backgroundColor ?? Colors.white,
    borderRadius: borderRadius ?? BorderRadius.circular(20),
    border: hasBorder
        ? Border.all(color: borderColor ?? Colors.grey.withValues(alpha: 0.08))
        : null,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 12,
        offset: const Offset(0, 2),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.02),
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Enhanced Color Scheme with better contrast and modern colors
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF2563EB), // Modern blue
      primaryContainer: Color(0xFFDBEAFE),
      onPrimaryContainer: Color(0xFF1E3A8A),
      secondary: Color(0xFFEC4899), // Modern pink
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFFDF2F8),
      onSecondaryContainer: Color(0xFF831843),
      tertiary: Color(0xFF06B6D4), // Modern cyan
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFCFFAFE),
      onTertiaryContainer: Color(0xFF164E63),
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFFFEF2F2),
      onErrorContainer: Color(0xFF991B1B),
      onSurface: Color(0xFF111827),
      surfaceContainerHighest: Color(0xFFF9FAFB),
      onSurfaceVariant: Color(0xFF6B7280),
      outline: Color(0xFFE5E7EB),
      outlineVariant: Color(0xFFF3F4F6),
      shadow: Color(0x1A000000),
      scrim: Color(0x66000000),
      inverseSurface: Color(0xFF111827),
      onInverseSurface: Color(0xFFF9FAFB),
      inversePrimary: Color(0xFF60A5FA),
    ),

    // Typography
    textTheme: const TextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      displaySmall: AppTypography.displaySmall,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      headlineSmall: AppTypography.headlineSmall,
      titleLarge: AppTypography.titleLarge,
      titleMedium: AppTypography.titleMedium,
      titleSmall: AppTypography.titleSmall,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.labelLarge,
      labelMedium: AppTypography.labelMedium,
      labelSmall: AppTypography.labelSmall,
    ),

    // Custom theme extensions
    extensions: const <ThemeExtension<dynamic>>[AppThemeExtension.light],

    // Clean App Bar Theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF111827),
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF111827),
        letterSpacing: -0.3,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: false,
    ),

    // Clean Card Theme with subtle shadows
    cardTheme: CardThemeData(
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      surfaceTintColor: Colors.transparent,
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      margin: const EdgeInsets.all(12),
    ),

    // Clean Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        minimumSize: const Size(0, 44),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: AppTypography.buttonMedium,
        minimumSize: const Size(0, 48),
        side: const BorderSide(color: AppColors.border),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: AppTypography.buttonMedium,
        minimumSize: const Size(0, 40),
      ),
    ),

    // Clean Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: const TextStyle(
        color: Color(0xFF9CA3AF),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: const TextStyle(
        color: Color(0xFF6B7280),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 4,
      shape: CircleBorder(),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      elevation: 8,
      selectedLabelStyle: AppTypography.labelSmall,
      unselectedLabelStyle: AppTypography.labelSmall,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceVariant,
      selectedColor: AppColors.primarySurface,
      secondarySelectedColor: AppColors.secondarySurface,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: AppTypography.labelMedium,
      secondaryLabelStyle: AppTypography.labelMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      pressElevation: 2,
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      elevation: 8,
      shadowColor: AppColors.shadow,
      surfaceTintColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: AppTypography.headlineSmall,
      contentTextStyle: AppTypography.bodyMedium,
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 8,
      shadowColor: AppColors.shadow,
      surfaceTintColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 1,
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 24),

    // Primary Icon Theme
    primaryIconTheme: const IconThemeData(color: AppColors.primary, size: 24),

    // List Tile Theme
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: AppTypography.bodyLarge,
      subtitleTextStyle: AppTypography.bodyMedium,
      leadingAndTrailingTextStyle: AppTypography.labelMedium,
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.neutral400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primarySurface;
        }
        return AppColors.neutral200;
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.surface;
      }),
      checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.neutral400;
      }),
    ),

    // Slider Theme
    sliderTheme: const SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.neutral200,
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primarySurface,
      valueIndicatorColor: AppColors.primary,
      valueIndicatorTextStyle: AppTypography.labelSmall,
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.neutral200,
      circularTrackColor: AppColors.neutral200,
    ),

    // Tab Bar Theme
    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textTertiary,
      labelStyle: AppTypography.labelLarge,
      unselectedLabelStyle: AppTypography.labelLarge,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
    ),

    // Tooltip Theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.neutral800,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: AppTypography.labelSmall.copyWith(
        color: AppColors.textOnPrimary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Snack Bar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.neutral800,
      contentTextStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textOnPrimary,
      ),
      actionTextColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Modern Dark Color Scheme with vibrant accents
    colorScheme: const ColorScheme.dark(
      // Primary - Vibrant Blue
      primary: Color(0xFF60A5FA), // Brighter blue for dark mode
      onPrimary: Color(0xFF0A0E1A),
      primaryContainer: Color(0xFF1E3A8A),
      onPrimaryContainer: Color(0xFFBFDBFE),

      // Secondary - Vibrant Orange
      secondary: Color(0xFFFB923C), // Brighter orange
      onSecondary: Color(0xFF0A0E1A),
      secondaryContainer: Color(0xFF9A3412),
      onSecondaryContainer: Color(0xFFFED7AA),

      // Tertiary - Vibrant Purple
      tertiary: Color(0xFFA78BFA), // Brighter purple
      onTertiary: Color(0xFF0A0E1A),
      tertiaryContainer: Color(0xFF6D28D9),
      onTertiaryContainer: Color(0xFFE9D5FF),

      // Error - Vibrant Red
      error: Color(0xFFF87171),
      onError: Color(0xFF0A0E1A),
      errorContainer: Color(0xFF991B1B),
      onErrorContainer: Color(0xFFFECDD3),

      // Surface - Deep dark with slight blue tint
      surface: Color(0xFF0F172A), // Slate-900
      onSurface: Color(0xFFF1F5F9), // Slate-100
      surfaceContainerHighest: Color(0xFF1E293B), // Slate-800
      onSurfaceVariant: Color(0xFFCBD5E1), // Slate-300
      // Outline
      outline: Color(0xFF475569), // Slate-600
      outlineVariant: Color(0xFF334155), // Slate-700
      // Shadow & Scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Inverse
      inverseSurface: Color(0xFFF8FAFC), // Slate-50
      onInverseSurface: Color(0xFF0F172A),
      inversePrimary: Color(0xFF2563EB),
    ),

    // Typography with better contrast
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(
        color: const Color(0xFFF8FAFC),
      ),
      displayMedium: AppTypography.displayMedium.copyWith(
        color: const Color(0xFFF8FAFC),
      ),
      displaySmall: AppTypography.displaySmall.copyWith(
        color: const Color(0xFFF8FAFC),
      ),
      headlineLarge: AppTypography.headlineLarge.copyWith(
        color: const Color(0xFFF1F5F9),
      ),
      headlineMedium: AppTypography.headlineMedium.copyWith(
        color: const Color(0xFFF1F5F9),
      ),
      headlineSmall: AppTypography.headlineSmall.copyWith(
        color: const Color(0xFFF1F5F9),
      ),
      titleLarge: AppTypography.titleLarge.copyWith(
        color: const Color(0xFFF1F5F9),
      ),
      titleMedium: AppTypography.titleMedium.copyWith(
        color: const Color(0xFFE2E8F0),
      ),
      titleSmall: AppTypography.titleSmall.copyWith(
        color: const Color(0xFFE2E8F0),
      ),
      bodyLarge: AppTypography.bodyLarge.copyWith(
        color: const Color(0xFFE2E8F0),
      ),
      bodyMedium: AppTypography.bodyMedium.copyWith(
        color: const Color(0xFFCBD5E1),
      ),
      bodySmall: AppTypography.bodySmall.copyWith(
        color: const Color(0xFFCBD5E1),
      ),
      labelLarge: AppTypography.labelLarge.copyWith(
        color: const Color(0xFFCBD5E1),
      ),
      labelMedium: AppTypography.labelMedium.copyWith(
        color: const Color(0xFFA8B3CF),
      ),
      labelSmall: AppTypography.labelSmall.copyWith(
        color: const Color(0xFF94A3B8),
      ),
    ),

    // Custom theme extensions
    extensions: const <ThemeExtension<dynamic>>[AppThemeExtension.dark],

    // Modern Dark App Bar with glassmorphism effect
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Color(0xFF0F172A), // Slate-900
      foregroundColor: Color(0xFFF1F5F9),
      surfaceTintColor: Color(0xFF60A5FA),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF1F5F9),
        letterSpacing: -0.5,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      centerTitle: false,
    ),

    // Modern Card Theme with elevated appearance
    cardTheme: CardThemeData(
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: const Color(0xFF60A5FA),
      color: const Color(0xFF1E293B), // Slate-800
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFF334155), // Slate-700
        ),
      ),
      margin: const EdgeInsets.all(8),
    ),

    // Elevated Button with gradient-like appearance
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: const Color(0xFF60A5FA),
        foregroundColor: const Color(0xFF0A0E1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        minimumSize: const Size(0, 50),
      ),
    ),

    // Outlined Button with modern border
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF60A5FA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        minimumSize: const Size(0, 50),
        side: const BorderSide(color: Color(0xFF475569), width: 1.5),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF60A5FA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
        minimumSize: const Size(0, 44),
      ),
    ),

    // Modern Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E293B), // Slate-800
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF475569), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF475569), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF60A5FA), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFF87171), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFF87171), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 15),
      labelStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
    ),

    // Floating Action Button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 4,
      highlightElevation: 8,
      shape: CircleBorder(),
      backgroundColor: Color(0xFF60A5FA),
      foregroundColor: Color(0xFF0A0E1A),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF0F172A),
      selectedItemColor: Color(0xFF60A5FA),
      unselectedItemColor: Color(0xFF64748B),
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF1E293B),
      selectedColor: const Color(0xFF1E3A8A),
      secondarySelectedColor: const Color(0xFF9A3412),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: const TextStyle(
        color: Color(0xFFE2E8F0),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Color(0xFFE2E8F0),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFF334155)),
      ),
      elevation: 0,
      pressElevation: 0,
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      elevation: 8,
      shadowColor: Colors.black54,
      surfaceTintColor: const Color(0xFF60A5FA),
      backgroundColor: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFF334155)),
      ),
      titleTextStyle: const TextStyle(
        color: Color(0xFFF1F5F9),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 15),
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 8,
      shadowColor: Colors.black54,
      surfaceTintColor: Color(0xFF60A5FA),
      backgroundColor: Color(0xFF1E293B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF334155)),
      ),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: Color(0xFF334155),
      thickness: 1,
      space: 1,
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: Color(0xFFCBD5E1), size: 24),
    primaryIconTheme: const IconThemeData(color: Color(0xFF60A5FA), size: 24),

    // List Tile Theme
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: TextStyle(
        color: Color(0xFFF1F5F9),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
      leadingAndTrailingTextStyle: TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 14,
      ),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF60A5FA);
        }
        return const Color(0xFF64748B);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF1E3A8A);
        }
        return const Color(0xFF334155);
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF60A5FA);
        }
        return const Color(0xFF1E293B);
      }),
      checkColor: WidgetStateProperty.all(const Color(0xFF0A0E1A)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: const BorderSide(color: Color(0xFF475569), width: 1.5),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF60A5FA);
        }
        return const Color(0xFF64748B);
      }),
    ),

    // Slider Theme
    sliderTheme: const SliderThemeData(
      activeTrackColor: Color(0xFF60A5FA),
      inactiveTrackColor: Color(0xFF334155),
      thumbColor: Color(0xFF60A5FA),
      overlayColor: Color(0x2960A5FA),
      valueIndicatorColor: Color(0xFF60A5FA),
      valueIndicatorTextStyle: TextStyle(
        color: Color(0xFF0A0E1A),
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFF60A5FA),
      linearTrackColor: Color(0xFF334155),
      circularTrackColor: Color(0xFF334155),
    ),

    // Tab Bar Theme
    tabBarTheme: const TabBarThemeData(
      labelColor: Color(0xFF60A5FA),
      unselectedLabelColor: Color(0xFF64748B),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
      ),
    ),

    // Tooltip Theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: const Color(0xFF334155),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        color: Color(0xFFF1F5F9),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Snack Bar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF334155),
      contentTextStyle: const TextStyle(
        color: Color(0xFFF1F5F9),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      actionTextColor: const Color(0xFF60A5FA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),
  );

  // ============================================================================
  // THEME EXTENSIONS & DESIGN TOKENS
  // ============================================================================

  /// Spacing constants for consistent padding and margins
  static const spacing = AppSpacing();

  /// Animation durations for consistent timing
  static const animations = AppAnimations();

  /// Shadow presets for consistent elevation
  static const shadows = AppShadows();

  /// Border radius presets
  static const radii = AppRadii();
}

/// Spacing constants following 8pt grid system
class AppSpacing {
  const AppSpacing();

  // Base spacing unit (8pt)
  static const double unit = 8.0;

  // Spacing scale
  double get xs => unit * 0.5; // 4pt
  double get sm => unit; // 8pt
  double get md => unit * 2; // 16pt
  double get lg => unit * 3; // 24pt
  double get xl => unit * 4; // 32pt
  double get xxl => unit * 6; // 48pt

  // Semantic spacing
  double get cardPadding => md; // 16pt
  double get screenPadding => md; // 16pt
  double get sectionSpacing => lg; // 24pt
  double get itemSpacing => sm; // 8pt
}

/// Animation duration constants
class AppAnimations {
  const AppAnimations();

  // Standard durations
  Duration get fast => const Duration(milliseconds: 150);
  Duration get normal => const Duration(milliseconds: 300);
  Duration get slow => const Duration(milliseconds: 500);

  // Specific use cases
  Duration get tap => const Duration(milliseconds: 150);
  Duration get transition => const Duration(milliseconds: 300);
  Duration get pageTransition => const Duration(milliseconds: 400);
  Duration get shimmer => const Duration(milliseconds: 1500);

  // Curves
  Curve get easeInOut => Curves.easeInOut;
  Curve get easeOut => Curves.easeOut;
  Curve get easeIn => Curves.easeIn;
  Curve get bounceOut => Curves.bounceOut;
  Curve get elasticOut => Curves.elasticOut;
}

/// Shadow presets for consistent elevation
class AppShadows {
  const AppShadows();

  // Light mode shadows
  List<BoxShadow> get sm => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  List<BoxShadow> get md => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  List<BoxShadow> get lg => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
  ];

  List<BoxShadow> get xl => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 48,
      offset: const Offset(0, 16),
    ),
  ];

  // Dark mode shadows (more prominent)
  List<BoxShadow> darkSm(Color primaryColor) => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  List<BoxShadow> darkMd(Color primaryColor) => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: primaryColor.withValues(alpha: 0.1),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  List<BoxShadow> darkLg(Color primaryColor) => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: primaryColor.withValues(alpha: 0.15),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
  ];
}

/// Border radius presets
class AppRadii {
  const AppRadii();

  double get xs => 4.0;
  double get sm => 8.0;
  double get md => 12.0;
  double get lg => 16.0;
  double get xl => 20.0;
  double get xxl => 24.0;
  double get full => 9999.0;

  // Semantic radii
  BorderRadius get button => BorderRadius.circular(md);
  BorderRadius get card => BorderRadius.circular(lg);
  BorderRadius get input => BorderRadius.circular(md);
  BorderRadius get dialog => BorderRadius.circular(xl);
  BorderRadius get bottomSheet =>
      const BorderRadius.vertical(top: Radius.circular(20));
}

/// Theme extension for custom app colors
@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.success,
    required this.warning,
    required this.info,
    required this.successContainer,
    required this.warningContainer,
    required this.infoContainer,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color success;
  final Color warning;
  final Color info;
  final Color successContainer;
  final Color warningContainer;
  final Color infoContainer;
  final Color shimmerBase;
  final Color shimmerHighlight;

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? successContainer,
    Color? warningContainer,
    Color? infoContainer,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return AppThemeExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      successContainer: successContainer ?? this.successContainer,
      warningContainer: warningContainer ?? this.warningContainer,
      infoContainer: infoContainer ?? this.infoContainer,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      successContainer: Color.lerp(
        successContainer,
        other.successContainer,
        t,
      )!,
      warningContainer: Color.lerp(
        warningContainer,
        other.warningContainer,
        t,
      )!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(
        shimmerHighlight,
        other.shimmerHighlight,
        t,
      )!,
    );
  }

  // Light theme extension
  static const light = AppThemeExtension(
    success: Color(0xFF10B981), // Green
    warning: Color(0xFFF59E0B), // Amber
    info: Color(0xFF3B82F6), // Blue
    successContainer: Color(0xFFD1FAE5),
    warningContainer: Color(0xFFFEF3C7),
    infoContainer: Color(0xFFDBEAFE),
    shimmerBase: Color(0xFFE5E7EB),
    shimmerHighlight: Color(0xFFF9FAFB),
  );

  // Dark theme extension
  static const dark = AppThemeExtension(
    success: Color(0xFF34D399), // Light Green
    warning: Color(0xFFFBBF24), // Light Amber
    info: Color(0xFF60A5FA), // Light Blue
    successContainer: Color(0xFF065F46),
    warningContainer: Color(0xFF78350F),
    infoContainer: Color(0xFF1E3A8A),
    shimmerBase: Color(0xFF1E293B),
    shimmerHighlight: Color(0xFF334155),
  );
}

/// Extension to easily access custom theme colors
extension ThemeExtras on ThemeData {
  AppThemeExtension get appColors =>
      extension<AppThemeExtension>() ?? AppThemeExtension.light;
}
