import 'package:flutter/material.dart';

/// Colors sampled directly from the reference design.
abstract class AppColors {
  // Splash background blue (top -> bottom), sampled color-managed (P3->sRGB).
  static const splashTop = Color(0xFF0362D1);
  static const splashBottom = Color(0xFF015FCA);

  // Primary action blue (Search Flights button, swap button).
  static const blue = Color(0xFF036AE0);

  // Page backgrounds.
  static const pageBg = Color(0xFFF1F1F1);
  static const resultsBg = Color(0xFFEBEBEB);

  // Text.
  static const text = Color(0xFF111111);
  static const gray = Color(0xFF9A9A9E);
  static const grayDark = Color(0xFF6F6F73);

  // Cards.
  static const cardTop = Color(0xFFFDFDFD);
  static const cardBottom = Color(0xFFF1F1F1);

  // "Best Option" sky glow at top of the Emirates card.
  static const bestGlow = Color(0xFFBFD4EE);

  // Airline brand colors.
  static const emiratesRed = Color(0xFFD71920);
  static const qatarBurgundy = Color(0xFF662046);
  static const ryanairNavy = Color(0xFF073590);
  static const airAsiaRed = Color(0xFFEE2E24);
}

const kCardRadius = 24.0;

LinearGradient cardGradient() => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.cardTop, AppColors.cardBottom],
    );
