import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import 'results_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.pageBg,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: _Header(),
                      ),
                      const SizedBox(height: 22),
                      const _CategoryTabs(),
                      const SizedBox(height: 18),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: _RouteCard(),
                      ),
                      const SizedBox(height: 14),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: _TripOptionsRow(),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _SearchButton(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const ResultsScreen()),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Offer Flights',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: _OfferCard(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const _BottomNav(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 18,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.text,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 11,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.text,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ),
          Image.asset('assets/images/logo_black.png', height: 20),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(CupertinoIcons.bell, size: 23, color: AppColors.text),
          ),
        ],
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Row(
              children: [
                Transform.rotate(
                  angle: math.pi / 4,
                  child:
                      const Icon(Icons.flight, size: 19, color: AppColors.text),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Flights',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
          _inactive(Icons.apartment, 'Hotels'),
          _inactive(CupertinoIcons.car_detailed, 'Cars'),
          _inactive(CupertinoIcons.bag, 'Packages'),
        ],
      ),
    );
  }

  Widget _inactive(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Icon(icon, size: 19, color: AppColors.gray),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteCard extends StatelessWidget {
  const _RouteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
      decoration: BoxDecoration(
        gradient: cardGradient(),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('From',
                    style: TextStyle(fontSize: 13, color: AppColors.gray)),
                SizedBox(height: 8),
                Text('SIN',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                      letterSpacing: -1.5,
                      height: 1.05,
                    )),
                SizedBox(height: 6),
                Text('Singapore',
                    style: TextStyle(fontSize: 13, color: AppColors.gray)),
              ],
            ),
          ),
          const _SwapButton(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text('To',
                    style: TextStyle(fontSize: 13, color: AppColors.gray)),
                SizedBox(height: 8),
                Text('DAC',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                      letterSpacing: -1.5,
                      height: 1.05,
                    )),
                SizedBox(height: 6),
                Text('Dhaka',
                    style: TextStyle(fontSize: 13, color: AppColors.gray)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SwapButton extends StatelessWidget {
  const _SwapButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      height: 64,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Faint arc behind the button.
          Positioned.fill(
            child: CustomPaint(painter: _ArcPainter()),
          ),
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue.withValues(alpha: 0.10),
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Transform.rotate(
                angle: math.pi / 2,
                child: const Icon(Icons.flight, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDADADE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final path = Path()
      ..moveTo(-14, size.height * 0.72)
      ..quadraticBezierTo(size.width / 2, size.height * 0.05, size.width + 14,
          size.height * 0.72);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TripOptionsRow extends StatelessWidget {
  const _TripOptionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _option(Icons.sync_alt, 'One Way'),
        const SizedBox(width: 12),
        _option(CupertinoIcons.person_2, '2 People'),
        const SizedBox(width: 12),
        _option(CupertinoIcons.calendar, 'Jun 20, 2026'),
      ],
    );
  }

  Widget _option(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          gradient: cardGradient(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 19, color: AppColors.text),
            const SizedBox(height: 9),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.grayDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(28),
        ),
        child: const Text(
          'Search Flights',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width - 40;
    final imageHeight = w * (548 / 1048);
    return SizedBox(
      height: imageHeight + 12,
      child: Stack(
        children: [
          // Stacked blue sheet peeking above the photo.
          Positioned(
            top: 0,
            left: 14,
            right: 14,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF87A9E3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Image.asset(
                'assets/images/offer_card.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: math.max(bottomInset, 12)),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(CupertinoIcons.house_fill, size: 24, color: AppColors.text),
          Icon(CupertinoIcons.ticket, size: 24, color: Color(0xFFB9B9BE)),
          Icon(CupertinoIcons.bookmark, size: 23, color: Color(0xFFB9B9BE)),
          Icon(CupertinoIcons.person, size: 24, color: Color(0xFFB9B9BE)),
        ],
      ),
    );
  }
}
