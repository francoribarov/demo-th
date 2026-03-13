import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Main theme configuration for the Table Hopping app.
/// Matches the design system from the Vite.js prototype.
class AppTheme {
  AppTheme._();

  /// Border radius value for extra-small rounding.
  static const double radiusXs = 4;

  /// Border radius value for small rounding.
  static const double radiusSm = 8;

  /// Border radius value for medium rounding.
  static const double radiusMd = 12;

  /// Border radius value for large rounding.
  static const double radiusLg = 16;

  /// Border radius value for extra-large rounding.
  static const double radiusXl = 20;

  /// Border radius value for 2x extra-large rounding.
  static const double radius2xl = 24;

  /// Border radius value for 3x extra-large rounding.
  static const double radius3xl = 32;

  /// Border radius value for full pill/circle shapes.
  static const double radiusFull = 999;

  /// Spacing value for extra-small gaps.
  static const double spacingXs = 4;

  /// Spacing value for small gaps.
  static const double spacingSm = 8;

  /// Spacing value for medium gaps.
  static const double spacingMd = 12;

  /// Spacing value for large gaps.
  static const double spacingLg = 16;

  /// Spacing value for extra-large gaps.
  static const double spacingXl = 20;

  /// Spacing value for 2x extra-large gaps.
  static const double spacing2xl = 24;

  /// Spacing value for 3x extra-large gaps.
  static const double spacing3xl = 32;

  /// Spacing value for 4x extra-large gaps.
  static const double spacing4xl = 40;

  /// Extra bottom padding for scrollable step content (e.g. publish wizard).
  static const double spacingScrollBottom = 100;

  /// Small shadow — for badges, chips, and floating labels.
  static List<BoxShadow> get shadowSm => [
    BoxShadow(
      color: AppColors.shadow.withOpacityValue(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  /// Medium shadow — for cards and elevated surfaces.
  static List<BoxShadow> get shadowMd => [
    BoxShadow(
      color: AppColors.shadow.withOpacityValue(0.05),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  /// Large shadow — for modals, drawers, and prominent cards.
  static List<BoxShadow> get shadowLg => [
    BoxShadow(
      color: AppColors.shadow.withOpacityValue(0.06),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];

  /// Upward shadow — for bottom bars and bottom navigation.
  static List<BoxShadow> get shadowUp => [
    BoxShadow(
      color: AppColors.shadow.withOpacityValue(0.06),
      blurRadius: 10,
      offset: const Offset(0, -4),
    ),
  ];

  /// Light theme configuration for the app.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.gameCream,
        onPrimaryContainer: AppColors.gameBrown,
        secondary: AppColors.secondary,
        onSecondary: AppColors.secondaryForeground,
        secondaryContainer: AppColors.gameCream,
        onSecondaryContainer: AppColors.gameBrown,
        tertiary: AppColors.accent,
        onTertiary: AppColors.accentForeground,
        onSurface: AppColors.cardForeground,
        error: AppColors.destructive,
        onError: AppColors.destructiveForeground,
      ),

      // Date Picker Theme
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.card,
        headerBackgroundColor: AppColors.gameRust,
        headerForegroundColor: AppColors.primaryForeground,
        rangeSelectionBackgroundColor: AppColors.gameCream,
        rangeSelectionOverlayColor: WidgetStateProperty.all(
          AppColors.gameRust.withOpacityValue(0.1),
        ),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryForeground;
          }
          return AppColors.gameBrown;
        }),
        todayForegroundColor: WidgetStateProperty.all(AppColors.gameRust),
        surfaceTintColor: const Color(0x00000000),
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.background,

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.gameBrown,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.titleLarge,
        iconTheme: const IconThemeData(color: AppColors.gameBrown),
      ),

      // Bottom navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.card,
        selectedItemColor: AppColors.gameRust,
        unselectedItemColor: AppColors.gameBrown,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          side: BorderSide(color: AppColors.gameBrown.withOpacityValue(0.1)),
        ),
        margin: EdgeInsets.zero,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gameRust,
          foregroundColor: AppColors.primaryForeground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius2xl),
          ),
          textStyle: AppTypography.labelLarge.copyWith(
            color: AppColors.primaryForeground,
          ),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.gameBrown,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius2xl),
          ),
          side: BorderSide(color: AppColors.gameBrown.withOpacityValue(0.3)),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.gameRust,
          textStyle: AppTypography.labelLarge.copyWith(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted,
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius2xl),
          borderSide: BorderSide(
            color: AppColors.gameBrown.withOpacityValue(0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius2xl),
          borderSide: BorderSide(
            color: AppColors.gameBrown.withOpacityValue(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius2xl),
          borderSide: const BorderSide(color: AppColors.gameRust, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius2xl),
          borderSide: const BorderSide(color: AppColors.destructive),
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPlaceholder,
        ),
        labelStyle: AppTypography.bodyMedium,
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.card,
        selectedColor: AppColors.gameCream,
        disabledColor: AppColors.muted,
        labelStyle: AppTypography.labelMedium,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius2xl),
          side: BorderSide(color: AppColors.gameBrown.withOpacityValue(0.2)),
        ),
      ),

      // Tab bar theme
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryForeground,
        unselectedLabelColor: AppColors.gameBrown,
        labelStyle: AppTypography.labelLarge,
        unselectedLabelStyle: AppTypography.labelLarge,
        indicator: BoxDecoration(
          color: AppColors.gameRust,
          borderRadius: BorderRadius.circular(radius2xl),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: AppColors.gameBrown.withOpacityValue(0.1),
        thickness: 1,
        space: 1,
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.gameRust;
          }
          return AppColors.muted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.gameRust.withOpacityValue(0.5);
          }
          return AppColors.muted.withOpacityValue(0.5);
        }),
      ),

      // Bottom sheet theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius3xl)),
        ),
        showDragHandle: true,
        dragHandleColor: AppColors.muted,
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius3xl),
        ),
        titleTextStyle: AppTypography.headlineMedium,
        contentTextStyle: AppTypography.bodyMedium,
      ),

      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gameBrown,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.primaryForeground,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
