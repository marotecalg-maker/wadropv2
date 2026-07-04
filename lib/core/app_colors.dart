import 'package:flutter/material.dart';

/// Central brand + semantic palette for Wadrop.
///
/// Only theme-level colours live here. Per-drink and per-workout accent
/// colours live next to their models so the palette stays dependency-free.
class AppColors {
  AppColors._();

  // ---- Brand ----------------------------------------------------------------
  static const Color primary = Color(0xFF4FA9F0);
  static const Color primaryBright = Color(0xFF63C2FF);
  static const Color primaryDeep = Color(0xFF1E7FD6);

  // Water fill gradient used in the globe.
  static const Color waterTop = Color(0xFF5AB8F2);
  static const Color waterBottom = Color(0xFF1B77CE);

  // ---- Semantic -------------------------------------------------------------
  static const Color success = Color(0xFF46D6A0);
  static const Color warning = Color(0xFFF5B14C);
  static const Color danger = Color(0xFFF46A60);
  static const Color streak = Color(0xFFFF7A3D);
  static const Color gold = Color(0xFFF2C14E);

  // ---- Dark surfaces (primary experience) -----------------------------------
  static const Color darkBgTop = Color(0xFF0E1626);
  static const Color darkBgBottom = Color(0xFF080D18);
  static const Color darkSurface = Color(0xFF141E33);
  static const Color darkSurfaceAlt = Color(0xFF1A2740);
  static const Color darkBorder = Color(0xFF25334F);
  static const Color darkTextPrimary = Color(0xFFEAF2FB);
  static const Color darkTextSecondary = Color(0xFF93A6C4);
  static const Color darkTextMuted = Color(0xFF5F7089);

  // ---- Light surfaces -------------------------------------------------------
  static const Color lightBgTop = Color(0xFFF3F8FD);
  static const Color lightBgBottom = Color(0xFFE8F1FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFF0F6FC);
  static const Color lightBorder = Color(0xFFDCE8F4);
  static const Color lightTextPrimary = Color(0xFF15263B);
  static const Color lightTextSecondary = Color(0xFF5B6E86);
}
