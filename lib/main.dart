import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/results_screen.dart';
import 'screens/splash_screen.dart';
import 'theme.dart';

/// Dev-only: launch straight into a screen with
/// `flutter run --dart-define=START=home|results`.
const _start = String.fromEnvironment('START');

void main() {
  runApp(const FlightBookingApp());
}

class FlightBookingApp extends StatelessWidget {
  const FlightBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        scaffoldBackgroundColor: AppColors.pageBg,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      home: switch (_start) {
        'home' => const HomeScreen(),
        'results' => const ResultsScreen(),
        _ => const SplashScreen(),
      },
    );
  }
}
