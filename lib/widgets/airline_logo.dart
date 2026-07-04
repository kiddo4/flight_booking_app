import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Circular airline badge: brand-colored disc with the airline glyph.
class AirlineLogo extends StatelessWidget {
  const AirlineLogo({
    super.key,
    required this.asset,
    required this.background,
    this.size = 34,
    this.glyphScale = 0.52,
    this.border,
  });

  final String asset;
  final Color background;
  final double size;
  final double glyphScale;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border != null ? Border.all(color: border!, width: 1) : null,
      ),
      child: Center(
        child: SvgPicture.asset(asset, width: size * glyphScale),
      ),
    );
  }
}
