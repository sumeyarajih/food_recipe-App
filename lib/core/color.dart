import 'package:flutter/material.dart';

/// App Color Palette
/// Centralized color definitions for consistent theming across the app
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Colors
  static const Color primary = Color(0xFFEC407A); // Pink
  static const Color primaryLight = Color(0xFFF48FB1);
  static const Color primaryDark = Color(0xFFC2185B);

  // Background Colors
  static const Color background = Color.fromARGB(255, 247, 230, 235); // Light pink background
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundGrey = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Accent Colors
  static const Color accent = Color(0xFFEC407A);
  static const Color accentLight = Color(0xFFF8BBD0);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // UI Element Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);
  static const Color shadow = Color(0x1A000000);

  // Rating/Star Color
  static const Color star = Color(0xFFFFD700); // Gold

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, backgroundWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
