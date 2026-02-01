import 'package:flutter/material.dart';

/// Project-wide color palette.
/// Use these for consistent UI (buttons, headers, links, surfaces).
class AppColors {
  AppColors._();

  /// Primary accent (teal) - headers, primary buttons.
  static const Color primary = Color(0xFF0A7863);

  /// Primary variant for hover/pressed states.
  static const Color primaryDark = Color(0xFF065A4A);

  /// Link and interactive text (e.g. Forgot password, Sign up).
  static const Color link = Color(0xFF3B82F6);

  /// Scaffold and page background.
  static const Color scaffoldBackground = Color(0xFFF8FAFC);

  /// Card and elevated surface.
  static const Color surface = Color(0xFFFFFFFF);

  /// Primary text (headings, labels).
  static const Color textPrimary = Color(0xFF0F172A);

  /// Secondary text (subtitles, hints).
  static const Color textSecondary = Color(0xFF64748B);

  /// Tertiary / placeholder.
  static const Color textTertiary = Color(0xFF94A3B8);

  /// Input border and dividers.
  static const Color border = Color(0xFFE2E8F0);

  /// Error text and validation.
  static const Color error = Color(0xFFEF4444);
}
