import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import '../widgets/airline_logo.dart';
import '../widgets/flight_path.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.resultsBg,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _Header(onBack: () => Navigator.of(context).pop()),
              ),
              const SizedBox(height: 20),
              const _FilterChips(),
              const SizedBox(height: 26),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                  physics: const ClampingScrollPhysics(),
                  children: const [
                    _FlightCard(
                      airline: 'Emirates',
                      logoAsset: 'assets/icons/emirates.svg',
                      logoColor: AppColors.emiratesRed,
                      price: 98,
                      departure: '9:15 PM',
                      departureCode: 'SIN',
                      arrival: '11:45 PM',
                      arrivalCode: 'DAC',
                      duration: '12:00',
                      bestOption: true,
                    ),
                    SizedBox(height: 16),
                    _FlightCard(
                      airline: 'Qatar Airways',
                      logoAsset: 'assets/icons/qatarairways.svg',
                      logoColor: AppColors.qatarBurgundy,
                      price: 105,
                      departure: '10:30 PM',
                      departureCode: 'SIN',
                      arrival: '1:00 AM',
                      arrivalCode: 'DAC',
                      duration: '11:30',
                    ),
                    SizedBox(height: 16),
                    _FlightCard(
                      airline: 'Ryan Airs',
                      logoAsset: 'assets/icons/ryanair.svg',
                      logoColor: AppColors.ryanairNavy,
                      price: 110,
                      departure: '8:45 PM',
                      departureCode: 'SIN',
                      arrival: '12:15 AM',
                      arrivalCode: 'DAC',
                      duration: '11:30',
                    ),
                    SizedBox(height: 16),
                    _FlightCard(
                      airline: 'Air Asia',
                      logoAsset: 'assets/icons/airasia.svg',
                      logoColor: AppColors.airAsiaRed,
                      price: 130,
                      departure: '9:00 PM',
                      departureCode: 'SIN',
                      arrival: '2:30 AM',
                      arrivalCode: 'DAC',
                      duration: '12:30',
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onBack,
              behavior: HitTestBehavior.opaque,
              child: const Icon(CupertinoIcons.arrow_left,
                  size: 22, color: AppColors.text),
            ),
          ),
          const Text(
            'Available Flights',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
              letterSpacing: -0.2,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Transform.rotate(
              angle: math.pi / 2,
              child: const Icon(Icons.tune, size: 21, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    const labels = ['Stops', 'Airlines', 'Hotels', 'Car Rentals'];
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: labels.length,
        separatorBuilder: (context, i) => const SizedBox(width: 10),
        itemBuilder: (context, i) => Container(
          padding: const EdgeInsets.only(left: 18, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Text(
                labels[i],
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down,
                  size: 19, color: AppColors.text),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlightCard extends StatelessWidget {
  const _FlightCard({
    required this.airline,
    required this.logoAsset,
    required this.logoColor,
    required this.price,
    required this.departure,
    required this.departureCode,
    required this.arrival,
    required this.arrivalCode,
    required this.duration,
    this.bestOption = false,
  });

  final String airline;
  final String logoAsset;
  final Color logoColor;
  final int price;
  final String departure;
  final String departureCode;
  final String arrival;
  final String arrivalCode;
  final String duration;
  final bool bestOption;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: cardGradient(),
            borderRadius: BorderRadius.circular(kCardRadius),
          ),
          child: Stack(
            children: [
              // Sky glow across the top of the best-option card.
              if (bestOption)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 96,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0, -1.1),
                        radius: 1.35,
                        colors: [
                          AppColors.bestGlow,
                          AppColors.bestGlow.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AirlineLogo(
                          asset: logoAsset,
                          background: logoColor,
                          size: 34,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          airline,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$$price',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                departure,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.text,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                departureCode,
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.gray),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 2),
                            FlightPath(
                              width: 84,
                              height: 24,
                              color: const Color(0xFFBFBFC4),
                              planeColor: AppColors.text,
                              planeSize: 15,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              duration,
                              style: const TextStyle(
                                  fontSize: 11, color: AppColors.gray),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                arrival,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.text,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                arrivalCode,
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.gray),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (bestOption)
          Positioned(
            top: -12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Best Option',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
