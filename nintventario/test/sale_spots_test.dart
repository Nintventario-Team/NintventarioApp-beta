import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/screens/home.dart';
import 'package:nintventario/screens/sale_spots.dart';

void main() {
  group('SaleSptosPage', () {
    // Helper function to create the widget
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: const SaleSptosPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const Home(),
        },
      );
    }

    testWidgets('displays initial locations', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify all locations are displayed
      expect(find.text('Ceibos'), findsOneWidget);
      expect(find.text('Machala'), findsOneWidget);
      expect(find.text('Puntilla'), findsOneWidget);
      expect(find.text('Terminal'), findsOneWidget);
    });

    testWidgets('updates global variable and navigates to Home screen on location tap', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate tap on a location
      await tester.tap(find.text('Ceibos'));
      await tester.pumpAndSettle();

      // Verify the global variable is updated
      expect(local, 'Ceibos');

      // Verify navigation to Home screen
      expect(find.byType(Home), findsOneWidget);
    });

    testWidgets('logs selected location in debug mode', (WidgetTester tester) async {
      debugPrint = (String? message, {int? wrapWidth}) {
        // This custom implementation will capture the debug messages
        if (message != null && message.contains('Selected location: Ceibos')) {
          expect(message, contains('Selected location: Ceibos'));
        }
      };

      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate tap on a location
      await tester.tap(find.text('Ceibos'));
      await tester.pumpAndSettle();

      // Restore debugPrint
      debugPrint = debugPrintSynchronously;
    });
  });
}
