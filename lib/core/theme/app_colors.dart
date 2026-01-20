import 'package:flutter/material.dart';

class AppColors {
  // Luxury Palette
  static const Color deepSea = Color(0xFF1A3A4A);
  static const Color oceanMist = Color(0xFF2C5A6A);
  static const Color warmSand = Color(0xFFE8DED1);
  static const Color champagne = Color(0xFFF5F0E8);
  static const Color ivory = Color(0xFFFDFBF7);

  // Accents
  static const Color sunsetGold = Color(0xFFD4A853);
  static const Color coralBlush = Color(0xFFE8A090);
  static const Color sageGreen = Color(0xFF8FA888);
  static const Color oceanBlue = Color(0xFF5B9AA0);

  // Legacy mappings (for backward compatibility)
  static const Color primary = deepSea;
  static const Color accent = sunsetGold;
  static const Color text = deepSea;
  static const Color background = champagne;
  static const Color surface = ivory;

  // Gradients
  static const LinearGradient heroOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0x40000000), Color(0x80000000)],
  );

  static const LinearGradient atmosphericBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [champagne, warmSand],
  );
}
