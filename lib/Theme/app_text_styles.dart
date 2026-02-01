import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Project-wide text styles.
/// Use for headings, body, labels, and buttons.
class AppTextStyles {
  AppTextStyles._();

  /// Large screen heading (e.g. "Hello, Sign in!").
  static TextStyle get headingLarge => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.surface,
        letterSpacing: -0.5,
      );

  /// Subtitle under heading.
  static TextStyle get subtitle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.surface,
        height: 1.4,
      );

  /// Form label (e.g. EMAIL, PASSWORD).
  static TextStyle get label => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.5,
      );

  /// Body text.
  static TextStyle get body => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  /// Body secondary (muted).
  static TextStyle get bodySecondary => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  /// Link text (Forgot password, Sign up).
  static TextStyle get link => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.link,
      );

  /// Primary button (e.g. SIGN IN).
  static TextStyle get buttonPrimary => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.surface,
        letterSpacing: 0.5,
      );

  /// Divider / small caps text (e.g. LOGIN WITH SOCIAL MEDIA).
  static TextStyle get dividerLabel => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      );
}
