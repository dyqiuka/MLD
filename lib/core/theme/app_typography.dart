import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography hierarchy for Healthcare & EdTech design system
class AppTypography {
  static TextTheme textTheme(bool isDark) {
    final primaryTextColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final secondaryTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return GoogleFonts.interTextTheme(
      TextTheme(
        // Heading 1 - Screen titles, Hero banners
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          color: primaryTextColor,
          height: 1.25,
        ),
        // Heading 2 - Section headers
        displayMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          color: primaryTextColor,
          height: 1.3,
        ),
        // Heading 3 - Card titles, Modal headers
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
          color: primaryTextColor,
          height: 1.35,
        ),
        // Subtitle 1 - Prominent highlights
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
          height: 1.4,
        ),
        // Subtitle 2 - Group labels
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
          height: 1.4,
        ),
        // Body 1 - Regular paragraphs
        bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: primaryTextColor,
          height: 1.5,
        ),
        // Body 2 - Secondary descriptions
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: secondaryTextColor,
          height: 1.45,
        ),
        // Caption - Metadata, stamps, tiny badges
        bodySmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: secondaryTextColor,
          height: 1.4,
        ),
        // Button text
        labelLarge: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          height: 1.2,
        ),
        // Badges / Tags
        labelSmall: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          height: 1.2,
        ),
      ),
    );
  }
}
