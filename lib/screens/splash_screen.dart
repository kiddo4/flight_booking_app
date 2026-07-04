import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import 'home_screen.dart';

/// First screen: blue hero with the plane. The plane "lands" into place on
/// launch, floats gently while idle, and takes off when Start Booking is
/// tapped. Geometry and colors follow the design mockup measurements.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entry = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500))
    ..forward();
  late final AnimationController _float = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 3200))
    ..repeat(reverse: true);
  late final AnimationController _takeoff = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900));

  late final Animation<double> _entryCurve =
      CurvedAnimation(parent: _entry, curve: Curves.easeOutCubic);
  late final Animation<double> _floatCurve =
      CurvedAnimation(parent: _float, curve: Curves.easeInOut);
  late final Animation<double> _takeoffCurve =
      CurvedAnimation(parent: _takeoff, curve: Curves.easeInCubic);

  bool _leaving = false;

  @override
  void dispose() {
    _entry.dispose();
    _float.dispose();
    _takeoff.dispose();
    super.dispose();
  }

  Future<void> _startBooking() async {
    if (_leaving) return;
    setState(() => _leaving = true);
    await _takeoff.forward();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 380),
        pageBuilder: (_, a, b) => const HomeScreen(),
        transitionsBuilder: (_, anim, a, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final h = size.height;
    final w = size.width;

    // Plane sized from the mockup: nose at ~6.2% height, tail at ~58%.
    final planeH = h * 0.52;
    final planeW = planeH * 1.193; // asset aspect ratio, fuselage centered

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.splashTop, AppColors.splashBottom],
            ),
          ),
          child: Stack(
            children: [
              // Broad central illumination behind the aircraft.
              Align(
                alignment: const Alignment(0, -1),
                child: IgnorePointer(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 42, sigmaY: 42),
                    child: Container(
                      width: w * 0.52,
                      height: h * 0.58,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.20),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // The plane.
              Positioned(
                top: h * 0.062,
                left: (w - planeW) / 2,
                width: planeW,
                child: AnimatedBuilder(
                  animation: Listenable.merge(
                      [_entryCurve, _floatCurve, _takeoffCurve]),
                  builder: (context, child) {
                    final entryDy = (1 - _entryCurve.value) * h * 0.34;
                    final floatDy = lerpDouble(-5, 5, _floatCurve.value)!;
                    final takeoffDy = -_takeoffCurve.value * h * 1.3;
                    final scale = lerpDouble(1.08, 1.0, _entryCurve.value)! *
                        lerpDouble(1.0, 0.94, _takeoffCurve.value)!;
                    return Transform.translate(
                      offset: Offset(0, entryDy + floatDy + takeoffDy),
                      child: Transform.scale(scale: scale, child: child),
                    );
                  },
                  child: Image.asset(
                    'assets/images/plane.png',
                    width: planeW,
                  ),
                ),
              ),

              // Bright core beam washing down the fuselage, under the card.
              Align(
                alignment: const Alignment(0, -1),
                child: IgnorePointer(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      width: w * 0.18,
                      height: h * 0.42,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.22),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Glass flight card overlapping the fuselage. The design sits
              // it slightly left of center, with rear sheets fanned right.
              Positioned(
                top: h * 0.14,
                left: 22,
                right: 55,
                child: _fadesWithTakeoff(
                  _slidesIn(
                      interval: const Interval(0.25, 0.75),
                      child: const _GlassFlightCard()),
                ),
              ),

              // Logo, headline, subtitle, CTA.
              Positioned(
                left: 24,
                right: 24,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: _fadesWithTakeoff(
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _slidesIn(
                          interval: const Interval(0.35, 0.85),
                          child: Image.asset('assets/images/logo_white.png',
                              width: 64),
                        ),
                        const SizedBox(height: 26),
                        _slidesIn(
                          interval: const Interval(0.42, 0.92),
                          child: const Text(
                            'Booking stress?\nSorted with AI',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 37,
                              fontWeight: FontWeight.w700,
                              height: 1.14,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        _slidesIn(
                          interval: const Interval(0.5, 1.0),
                          child: const SizedBox(
                            width: 278,
                            child: Text(
                              'Tired of booking hassles? Let AI take care of it easily and efficiently.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xE0B6D5ED),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                height: 1.45,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 42),
                        _slidesIn(
                          interval: const Interval(0.55, 1.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _StartBookingButton(onTap: _startBooking),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Entry: fade + rise, staggered by [interval].
  Widget _slidesIn({required Interval interval, required Widget child}) {
    final anim = CurvedAnimation(parent: _entry, curve: interval);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, c) => Opacity(
        opacity: anim.value,
        child: Transform.translate(
            offset: Offset(0, (1 - anim.value) * 18), child: c),
      ),
      child: child,
    );
  }

  /// Everything except the plane fades out quickly during takeoff.
  Widget _fadesWithTakeoff(Widget child) {
    final fade = CurvedAnimation(
        parent: _takeoff,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOut));
    return AnimatedBuilder(
      animation: fade,
      builder: (context, c) => Opacity(opacity: 1 - fade.value, child: c),
      child: child,
    );
  }
}

class _GlassFlightCard extends StatelessWidget {
  const _GlassFlightCard();

  static const _fill = Color(0x4DA9CFEA); // frosted cyan, ~30%
  static const _edge = Color(0xBFBFEFFF); // hairline cyan-white

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Two rear sheets fanned toward the bottom-right.
        Positioned(
          left: 36,
          right: -34,
          top: 34,
          bottom: -30,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0x17A7D4ED),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0x26BFEFFF), width: 1),
            ),
          ),
        ),
        Positioned(
          left: 18,
          right: -16,
          top: 18,
          bottom: -16,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0x1FA7D4ED),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0x40BFEFFF), width: 1),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: _fill,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: _edge, width: 1),
              ),
              child: Row(
                children: [
                  _endpoint('9:15 PM', 'SIN • Apr 27',
                      crossAxisAlignment: CrossAxisAlignment.start),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 24,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Positioned.fill(
                                child: CustomPaint(painter: _RouteArcPainter()),
                              ),
                              Transform.rotate(
                                angle: math.pi / 2,
                                child: const Icon(Icons.flight,
                                    color: Colors.white, size: 22),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text('2h 30m',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                  _endpoint('11:45 PM', 'DAC • Apr 27',
                      crossAxisAlignment: CrossAxisAlignment.end),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _endpoint(String time, String sub,
      {required CrossAxisAlignment crossAxisAlignment}) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
            )),
        const SizedBox(height: 7),
        Text(sub,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }
}

/// Shallow route arc that fades out toward both ends; the plane glyph sits
/// on its apex.
class _RouteArcPainter extends CustomPainter {
  const _RouteArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.0),
          Colors.white.withValues(alpha: 0.65),
          Colors.white.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);
    final path = Path()
      ..moveTo(0, size.height * 0.95)
      ..quadraticBezierTo(
          size.width / 2, -size.height * 0.25, size.width, size.height * 0.95);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RouteArcPainter old) => false;
}

class _StartBookingButton extends StatelessWidget {
  const _StartBookingButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(31),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            height: 62,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0x669CC8EC),
              borderRadius: BorderRadius.circular(31),
              border: Border.all(color: const Color(0xBFBDEEFF), width: 1),
            ),
            child: const Text(
              'Start Booking',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
