import 'package:flutter/material.dart';

/// Design tokens derived from the Vite.js prototype's global.css
/// All colors use HSL values converted to Flutter Color format
class AppColors {
  AppColors._();

  // Primary brand colors (from CSS variables)
  /// Primary brand color.
  static const Color primary = Color(0xFFCC6B24); // HSL(25, 70%, 50%)
  /// Foreground color for primary backgrounds.
  static const Color primaryForeground = Color(0xFFFFFFFF);

  /// Secondary brand color.
  static const Color secondary = Color(0xFFF5D966); // HSL(45, 90%, 70%)
  /// Foreground color for secondary backgrounds.
  static const Color secondaryForeground = Color(0xFF3D2E1F);

  /// Accent color for highlights.
  static const Color accent = Color(0xFFE84C2B); // HSL(15, 85%, 55%)
  /// Foreground color for accent backgrounds.
  static const Color accentForeground = Color(0xFFFFFFFF);

  // Background and foreground
  /// App background color.
  static const Color background = Color(0xFFF7F3ED); // HSL(45, 20%, 96%)
  /// Default text/foreground color.
  static const Color foreground = Color(0xFF3D2E1F); // HSL(25, 30%, 15%)

  // Card colors
  /// Card surface color.
  static const Color card = Color(0xFFFFFFFF);

  /// Card foreground color.
  static const Color cardForeground = Color(0xFF3D2E1F);

  // Muted colors
  /// Muted background color.
  static const Color muted = Color(0xFFD9D1C4); // HSL(45, 20%, 80%)
  /// Muted foreground color.
  static const Color mutedForeground = Color(0xFF665C4D); // HSL(25, 20%, 40%)

  // Border and input
  /// Default border color.
  static const Color border = Color(0xFFDDD5C7); // HSL(45, 30%, 85%)
  /// Default input fill color.
  static const Color input = Color(0xFFEDE9E1); // HSL(45, 20%, 92%)

  // Destructive
  /// Destructive action color.
  static const Color destructive = Color(0xFFE55050); // HSL(0, 84.2%, 60.2%)
  /// Foreground color for destructive backgrounds.
  static const Color destructiveForeground = Color(0xFFF8FAFC);

  // Game-specific colors (custom theme)
  /// Game UI cream color.
  static const Color gameCream = Color(0xFFFBEFD5); // HSL(45, 90%, 88%)
  /// Game UI brown color.
  static const Color gameBrown = Color(0xFF805D40); // HSL(25, 45%, 35%)
  /// Game UI gold color.
  static const Color gameGold = Color(0xFFFFCC33); // HSL(45, 100%, 60%)
  /// Game UI rust color.
  static const Color gameRust = Color(0xFFE84C2B); // HSL(15, 85%, 55%)
  /// Game UI sage color.
  static const Color gameSage = Color(0xFF70B870); // HSL(120, 25%, 55%)
  /// Game UI navy color.
  static const Color gameNavy = Color(0xFF204060); // HSL(200, 50%, 25%)

  // Additional utility colors
  /// Success state color.
  static const Color success = Color(0xFF22C55E);

  /// Warning state color.
  static const Color warning = Color(0xFFEAB308);

  /// Error state color (alias for [destructive]).
  static const Color error = destructive;

  /// Informational state color.
  static const Color info = Color(0xFF3B82F6);

  /// Reusable shadow color for elevation.
  static const Color shadow = Color(0xFF3D2E1F);

  /// Soft success background surface.
  static const Color successSurface = Color(0xFFEAF7EA);

  /// Soft error background surface.
  static const Color errorSurface = Color(0xFFFDECEC);

  /// Border token for highlighted chips.
  static const Color goldBorder = Color(0xFFF3D58A);

  // Rental status semantic colors
  /// Pending status color (amber/orange).
  static const Color statusPending = Color(0xFFF59E0B);

  /// Accepted status color (green).
  static const Color statusAccepted = Color(0xFF22C55E);

  /// Active status color (blue).
  static const Color statusActive = Color(0xFF3B82F6);

  /// Returned status color (navy).
  static const Color statusReturned = gameNavy;

  /// Finished status color (muted).
  static const Color statusFinished = mutedForeground;

  /// Rejected / cancelled status color (destructive red).
  static const Color statusRejected = destructive;

  // Semantic text colors (gameBrown at fixed opacities)
  /// Secondary text — gameBrown at 80% opacity.
  static const Color textSecondary = Color(0xCC805D40);

  /// Tertiary text — gameBrown at 70% opacity.
  static const Color textTertiary = Color(0xB3805D40);

  static const Color isSelected = Color(0xFFE5E5E5);

  /// Muted text — gameBrown at 60% opacity.
  static const Color textMuted = Color(0x99805D40);

  /// Placeholder / hint text — gameBrown at 50% opacity.
  static const Color textPlaceholder = Color(0x80805D40);

  // Opacity variations for gameBrown
  /// Returns [gameBrown] with the provided opacity.
  static Color gameBrownWithOpacity(double opacity) =>
      gameBrown.withOpacityValue(opacity);

  // Gradient palette for category cards (from Home.tsx)
  /// Gradient palette for category cards.
  static const List<List<Color>> gradientPalette = [
    [
      Color(0xFFFEF3C7),
      Color(0xFFFFF7ED),
      Color(0xFFFEF9C3),
    ], // amber-orange-yellow
    [
      Color(0xFFFFE4E6),
      Color(0xFFFCE7F3),
      Color(0xFFF5D0FE),
    ], // rose-pink-fuchsia
    [
      Color(0xFFE0F2FE),
      Color(0xFFEFF6FF),
      Color(0xFFE0E7FF),
    ], // sky-blue-indigo
    [
      Color(0xFFD1FAE5),
      Color(0xFFDCFCE7),
      Color(0xFFECFCCB),
    ], // emerald-green-lime
    [
      Color(0xFFF3E8FF),
      Color(0xFFEDE9FE),
      Color(0xFFFFE4E6),
    ], // purple-violet-rose
    [Color(0xFFCFFAFE), Color(0xFFCCFBF1), Color(0xFFDBEAFE)], // cyan-teal-blue
  ];
}

/// Opacity helpers for [Color].
extension ColorOpacity on Color {
  /// Returns a color with clamped opacity in the 0.0 to 1.0 range.
  Color withOpacityValue(double opacity) {
    final clampedOpacity = opacity.clamp(0.0, 1.0);
    return withAlpha((255 * clampedOpacity).round());
  }
}
