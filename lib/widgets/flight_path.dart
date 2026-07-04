import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Dashed arc used between departure/arrival times, with a plane
/// silhouette sitting on top of the arc.
class FlightPath extends StatelessWidget {
  const FlightPath({
    super.key,
    this.width = 76,
    this.height = 26,
    this.color = const Color(0xFFB9B9BE),
    this.planeColor = const Color(0xFF111111),
    this.planeSize = 16,
  });

  final double width;
  final double height;
  final Color color;
  final Color planeColor;
  final double planeSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(child: CustomPaint(painter: _DashedArcPainter(color))),
          Transform.rotate(
            angle: math.pi / 2,
            child: Icon(Icons.flight, size: planeSize, color: planeColor),
          ),
        ],
      ),
    );
  }
}

class _DashedArcPainter extends CustomPainter {
  _DashedArcPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    // Shallow arc across the box, bowing upward.
    final path = Path()
      ..moveTo(0, size.height * 0.9)
      ..quadraticBezierTo(
          size.width / 2, -size.height * 0.55, size.width, size.height * 0.9);

    // Dash it manually.
    const dash = 3.5, gap = 3.5;
    for (final metric in path.computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(
            metric.extractPath(d, math.min(d + dash, metric.length)), paint);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedArcPainter old) => old.color != color;
}
