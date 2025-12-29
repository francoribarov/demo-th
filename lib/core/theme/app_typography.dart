import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';

/// Typography system matching the Vite.js prototype.
/// Uses Inter font family with weights 400, 600, 700, 800.
class AppTypography {
  AppTypography._();

  static const String _fontFamily = 'Inter';

  /// Returns the Inter text theme for the app.
  static TextTheme get textTheme => Typography.material2021().black.apply(fontFamily: _fontFamily);

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required double height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Display text style (largest).
  static TextStyle get displayLarge =>
      _style(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.gameBrown, height: 1.2);

  /// Display text style (medium).
  static TextStyle get displayMedium =>
      _style(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.gameBrown, height: 1.2);

  /// Display text style (small).
  static TextStyle get displaySmall =>
      _style(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.gameBrown, height: 1.3);

  /// Headline text style (large).
  static TextStyle get headlineLarge =>
      _style(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.gameBrown, height: 1.3);

  /// Headline text style (medium).
  static TextStyle get headlineMedium =>
      _style(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.gameBrown, height: 1.4);

  /// Headline text style (small).
  static TextStyle get headlineSmall =>
      _style(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.gameBrown, height: 1.4);

  /// Title text style (large).
  static TextStyle get titleLarge =>
      _style(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.gameBrown, height: 1.4);

  /// Title text style (medium).
  static TextStyle get titleMedium =>
      _style(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.gameBrown, height: 1.5);

  /// Title text style (small).
  static TextStyle get titleSmall =>
      _style(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.gameBrown, height: 1.5);

  /// Body text style (large).
  static TextStyle get bodyLarge =>
      _style(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.gameBrown, height: 1.5);

  /// Body text style (medium).
  static TextStyle get bodyMedium =>
      _style(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.gameBrown, height: 1.5);

  /// Body text style (small).
  static TextStyle get bodySmall =>
      _style(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.gameBrown, height: 1.5);

  /// Label text style (large).
  static TextStyle get labelLarge => _style(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.gameBrown,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// Label text style (medium).
  static TextStyle get labelMedium => _style(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.gameBrown,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// Label text style (small).
  static TextStyle get labelSmall => _style(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.gameBrown,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// Price emphasis text style.
  static TextStyle get price =>
      _style(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.gameBrown, height: 1.2);

  /// Compact price emphasis text style.
  static TextStyle get priceSmall =>
      _style(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.gameBrown, height: 1.2);

  /// Category chip text style.
  static TextStyle get categoryChip =>
      _style(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gameBrown, height: 1.3);

  /// Section header text style.
  static TextStyle get sectionHeader => _style(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.gameRust,
    letterSpacing: 1.2,
    height: 1.4,
  );
}
