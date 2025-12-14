import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modern Arabic fonts configuration
/// This file provides easy access to different modern Arabic fonts
class ArabicFonts {
  
  /// Tajawal - Modern, elegant Arabic font with excellent readability
  static TextTheme getTajawalTheme() {
    return GoogleFonts.tajawalTextTheme().copyWith(
      // Headlines
      headlineLarge: GoogleFonts.tajawal(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      headlineMedium: GoogleFonts.tajawal(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
      ),
      headlineSmall: GoogleFonts.tajawal(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      // Titles
      titleLarge: GoogleFonts.tajawal(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.tajawal(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.tajawal(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      // Body text
      bodyLarge: GoogleFonts.tajawal(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
      ),
      bodyMedium: GoogleFonts.tajawal(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.tajawal(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      // Labels
      labelLarge: GoogleFonts.tajawal(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.tajawal(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.tajawal(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Cairo - Contemporary Arabic font with clean lines
  static TextTheme getCairoTheme() {
    return GoogleFonts.cairoTextTheme().copyWith(
      // Headlines
      headlineLarge: GoogleFonts.cairo(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),
      headlineMedium: GoogleFonts.cairo(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
      headlineSmall: GoogleFonts.cairo(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      // Titles
      titleLarge: GoogleFonts.cairo(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      titleSmall: GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      // Body text
      bodyLarge: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
      ),
      bodyMedium: GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
      ),
      bodySmall: GoogleFonts.cairo(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
      ),
      // Labels
      labelLarge: GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.cairo(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
      labelSmall: GoogleFonts.cairo(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
    );
  }

  /// Almarai - Modern Saudi-inspired Arabic font
  static TextTheme getAlmaraiTheme() {
    return GoogleFonts.almaraiTextTheme().copyWith(
      // Headlines
      headlineLarge: GoogleFonts.almarai(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
      ),
      headlineMedium: GoogleFonts.almarai(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
      headlineSmall: GoogleFonts.almarai(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      // Titles
      titleLarge: GoogleFonts.almarai(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.almarai(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
      titleSmall: GoogleFonts.almarai(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
      // Body text
      bodyLarge: GoogleFonts.almarai(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.2,
      ),
      bodyMedium: GoogleFonts.almarai(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.2,
      ),
      bodySmall: GoogleFonts.almarai(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.3,
      ),
      // Labels
      labelLarge: GoogleFonts.almarai(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.almarai(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelSmall: GoogleFonts.almarai(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    );
  }

  /// Noto Sans Arabic - Google's comprehensive Arabic font
  static TextTheme getNotoSansArabicTheme() {
    return GoogleFonts.notoSansArabicTextTheme().copyWith(
      // Headlines
      headlineLarge: GoogleFonts.notoSansArabic(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: GoogleFonts.notoSansArabic(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
      ),
      headlineSmall: GoogleFonts.notoSansArabic(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      // Titles
      titleLarge: GoogleFonts.notoSansArabic(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.notoSansArabic(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.notoSansArabic(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      // Body text
      bodyLarge: GoogleFonts.notoSansArabic(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.notoSansArabic(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.notoSansArabic(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      // Labels
      labelLarge: GoogleFonts.notoSansArabic(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.notoSansArabic(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.notoSansArabic(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Get AppBar style for specific font
  static TextStyle getAppBarStyle(String fontName) {
    switch (fontName.toLowerCase()) {
      case 'tajawal':
        return GoogleFonts.tajawal(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        );
      case 'cairo':
        return GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        );
      case 'almarai':
        return GoogleFonts.almarai(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        );
      case 'notosansarabic':
        return GoogleFonts.notoSansArabic(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );
      default:
        return GoogleFonts.tajawal(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        );
    }
  }

  /// Get input label style for specific font
  static TextStyle getInputLabelStyle(String fontName) {
    switch (fontName.toLowerCase()) {
      case 'tajawal':
        return GoogleFonts.tajawal(fontWeight: FontWeight.w500);
      case 'cairo':
        return GoogleFonts.cairo(fontWeight: FontWeight.w500);
      case 'almarai':
        return GoogleFonts.almarai(fontWeight: FontWeight.w400);
      case 'notosansarabic':
        return GoogleFonts.notoSansArabic(fontWeight: FontWeight.w500);
      default:
        return GoogleFonts.tajawal(fontWeight: FontWeight.w500);
    }
  }

  /// Get button text style for specific font
  static TextStyle getButtonTextStyle(String fontName) {
    switch (fontName.toLowerCase()) {
      case 'tajawal':
        return GoogleFonts.tajawal(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        );
      case 'cairo':
        return GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        );
      case 'almarai':
        return GoogleFonts.almarai(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        );
      case 'notosansarabic':
        return GoogleFonts.notoSansArabic(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        );
      default:
        return GoogleFonts.tajawal(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        );
    }
  }
}
