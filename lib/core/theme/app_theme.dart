import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.montserratTextTheme()
          .apply(bodyColor: AppColors.text, displayColor: AppColors.deepSea)
          .copyWith(
            displayLarge: GoogleFonts.playfairDisplay(
              color: AppColors.deepSea,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: GoogleFonts.playfairDisplay(
              color: AppColors.deepSea,
              fontWeight: FontWeight.bold,
            ),
            displaySmall: GoogleFonts.playfairDisplay(
              color: AppColors.deepSea,
              fontWeight: FontWeight.bold,
            ),
            headlineLarge: GoogleFonts.playfairDisplay(
              color: AppColors.deepSea,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: GoogleFonts.playfairDisplay(
              color: AppColors.deepSea,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}
