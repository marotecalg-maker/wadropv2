import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Builds the light and dark [ThemeData] for Wadrop.
class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Color(0xFF03121F),
      secondary: AppColors.primaryBright,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      error: AppColors.danger,
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppColors.darkBgBottom,
      canvasColor: AppColors.darkBgBottom,
      dividerColor: AppColors.darkBorder,
      cardTheme: _cardTheme(AppColors.darkSurface, AppColors.darkBorder),
      textTheme: _textTheme(
        AppColors.darkTextPrimary,
        AppColors.darkTextSecondary,
      ),
      navigationBarTheme: _navBarTheme(
        surface: const Color(0xFF0E1626),
        selected: AppColors.primaryBright,
        unselected: AppColors.darkTextSecondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.darkTextPrimary,
      ),
      dialogTheme: const DialogThemeData(backgroundColor: AppColors.darkSurface),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkSurfaceAlt,
        contentTextStyle: TextStyle(color: AppColors.darkTextPrimary),
      ),
    );
  }

  static ThemeData light() {
    const scheme = ColorScheme.light(
      primary: AppColors.primaryDeep,
      onPrimary: Colors.white,
      secondary: AppColors.primary,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      error: AppColors.danger,
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppColors.lightBgBottom,
      canvasColor: AppColors.lightBgBottom,
      dividerColor: AppColors.lightBorder,
      cardTheme: _cardTheme(AppColors.lightSurface, AppColors.lightBorder),
      textTheme: _textTheme(
        AppColors.lightTextPrimary,
        AppColors.lightTextSecondary,
      ),
      navigationBarTheme: _navBarTheme(
        surface: Colors.white,
        selected: AppColors.primaryDeep,
        unselected: AppColors.lightTextSecondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.lightTextPrimary,
      ),
      dialogTheme:
          const DialogThemeData(backgroundColor: AppColors.lightSurface),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  // ---- Shared pieces --------------------------------------------------------

  static ThemeData _base(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Roboto',
      splashFactory: InkSparkle.splashFactory,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          side: BorderSide(color: scheme.primary.withValues(alpha: 0.4)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
    );
  }

  static CardThemeData _cardTheme(Color surface, Color border) {
    return CardThemeData(
      color: surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: border),
      ),
    );
  }

  static NavigationBarThemeData _navBarTheme({
    required Color surface,
    required Color selected,
    required Color unselected,
  }) {
    return NavigationBarThemeData(
      backgroundColor: surface,
      elevation: 0,
      height: 68,
      surfaceTintColor: Colors.transparent,
      indicatorColor: selected.withValues(alpha: 0.16),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final color =
            states.contains(WidgetState.selected) ? selected : unselected;
        return IconThemeData(color: color, size: 26);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final color =
            states.contains(WidgetState.selected) ? selected : unselected;
        return TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        );
      }),
    );
  }

  static TextTheme _textTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: TextStyle(color: primary, fontWeight: FontWeight.w800),
      headlineMedium:
          TextStyle(color: primary, fontWeight: FontWeight.w800, fontSize: 24),
      titleLarge:
          TextStyle(color: primary, fontWeight: FontWeight.w700, fontSize: 20),
      titleMedium:
          TextStyle(color: primary, fontWeight: FontWeight.w700, fontSize: 16),
      bodyLarge: TextStyle(color: primary, fontSize: 15),
      bodyMedium: TextStyle(color: secondary, fontSize: 14),
      labelLarge:
          TextStyle(color: primary, fontWeight: FontWeight.w600, fontSize: 14),
      labelMedium: TextStyle(color: secondary, fontSize: 12),
    );
  }
}
