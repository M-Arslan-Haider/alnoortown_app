import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────
///  APP COLORS  –  single source of truth for the whole app
/// ─────────────────────────────────────────────────────────────
///
///  Usage:
///    import '../core/app_colors.dart';
///
///  Then reference any color with:
///    AppColors.gold, AppColors.charcoal, etc.
///
class AppColors {
  AppColors._(); // prevent instantiation

  // ── Whites & backgrounds ──────────────────────────────────
  static const Color white     = Color(0xFFFFFFFF);
  static const Color offWhite  = Color(0xFFF9F6F0);
  static const Color inputFill = Color(0xFFFAF8F4);

  // ── Borders / dividers ────────────────────────────────────
  static const Color divider   = Color(0xFFE8E2D6);
  static const Color greyLight = Color(0xFFD5D0C8);

  // ── Gold palette ──────────────────────────────────────────
  static const Color goldDark  = Color(0xFF9E7D35);
  static const Color gold      = Color(0xFFC9A84C);
  static const Color goldLight = Color(0xFFE2C97E);

  // ── Text ─────────────────────────────────────────────────
  static const Color charcoal  = Color(0xFF1E1E1E);
  static const Color grey      = Color(0xFF888888);

  // ── Semantic ─────────────────────────────────────────────
  static const Color error     = Color(0xFFB94040);
  static const Color success   = Color(0xFF2E7D4F);

  // ── Gradients (convenience) ──────────────────────────────
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldDark, gold, goldLight],
    stops:  [0.0, 0.5, 1.0],
  );

  static const LinearGradient goldAccentBar = LinearGradient(
    colors: [goldDark, goldLight, goldDark],
  );

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [goldDark, gold],
    begin:  Alignment.topLeft,
    end:    Alignment.bottomRight,
  );
}