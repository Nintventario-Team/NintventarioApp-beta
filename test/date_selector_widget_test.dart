import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/widgets/date_selector_widget.dart';

void main() {
  group('DateSelectorWidget', () {
    // Helper function to create the widget
    Widget createWidgetUnderTest({required void Function(DateTime) onDateSelected}) {
      return MaterialApp(
        home: Scaffold(
          body: DateSelectorWidget(onDateSelected: onDateSelected),
        ),
      );
    }

    testWidgets('displays initial selected date', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(onDateSelected: (_) {}));
      
      // Initial date displayed should be today's date
      final DateTime initialDate = DateTime.now();
      expect(find.text('${initialDate.toLocal()}'.split(' ')[0]), findsOneWidget);
    });

    testWidgets('opens date picker on tap', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(onDateSelected: (_) {}));
      
      // Simulate tap to open date picker
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();
      
      // Verify the date picker dialog is shown
      expect(find.byType(CalendarDatePicker), findsOneWidget);
    });

    testWidgets('calls onDateSelected with the picked date', (WidgetTester tester) async {
      DateTime? selectedDate;
      await tester.pumpWidget(createWidgetUnderTest(onDateSelected: (DateTime date) {
        selectedDate = date;
      }));
      
      // Simulate tap to open date picker
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();
      
      // Find the 'OK' button in the date picker dialog
      final DateTime pickedDate = DateTime.now().add(const Duration(days: 1));
      final Finder dayToSelect = find.text('${pickedDate.day}');
      await tester.tap(dayToSelect);
      await tester.pumpAndSettle();

      // Simulate pressing the 'OK' button
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      
      // Verify the callback is called with the picked date
      expect(selectedDate, isNotNull);
      expect(selectedDate, equals(DateTime(pickedDate.year, pickedDate.month, pickedDate.day)));
    });
  });
}
