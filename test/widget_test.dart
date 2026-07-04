import 'package:flutter_test/flutter_test.dart';

import 'package:flight_booking_app/main.dart';

void main() {
  testWidgets('app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const FlightBookingApp());
    expect(find.text('Start Booking'), findsOneWidget);
  });
}
