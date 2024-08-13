import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/screens/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{}); // Mock SharedPreferences
  });

  testWidgets('DraftsScreen should display a loading indicator while loading drafts', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DraftsScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DraftsScreen should display "No drafts available" when no drafts exist', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DraftsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('No hay borradores disponibles.'), findsOneWidget);
  });

  testWidgets('DraftsScreen should display a list of drafts', (WidgetTester tester) async {
    final Draft draft1 = Draft(id: '1', employee: 'John Doe');
    final Draft draft2 = Draft(id: '2', employee: 'Jane Doe');
    await draft1.saveDraft();
    await draft2.saveDraft();

    await tester.pumpWidget(const MaterialApp(home: DraftsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('ID: 1'), findsOneWidget);
    expect(find.text('ID: 2'), findsOneWidget);
  });
}
