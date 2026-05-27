import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color cream = Color(0xFFFBF5EE);
  static const Color deepBrown = Color(0xFF2C1810);
  static const Color coffeeBrown = Color(0xFF5C3D2E);
  static const Color gardenGreen = Color(0xFF6B8F71);
  static const Color accentGold = Color(0xFFC8954E);
  static const Color muted = Color(0xFF7A6A60);

  static ThemeData get light {
    final textTheme = TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 58,
        fontWeight: FontWeight.w700,
        color: deepBrown,
        height: 1.08,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: deepBrown,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: deepBrown,
      ),
      titleLarge: GoogleFonts.manrope(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: deepBrown,
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: deepBrown,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: muted,
        height: 1.6,
      ),
      labelLarge: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: coffeeBrown,
        primary: coffeeBrown,
        secondary: gardenGreen,
        tertiary: accentGold,
        surface: Colors.white,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: cream.withValues(alpha: 0.95),
        foregroundColor: deepBrown,
        elevation: 0,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: deepBrown,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0x1A5C3D2E)),
        ),
      ),
    );
  }
}
