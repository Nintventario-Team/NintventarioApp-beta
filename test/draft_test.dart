import 'package:flutter_test/flutter_test.dart';
import 'package:nintventario/classes/draft.dart';
import 'package:nintventario/classes/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{}); // Mock SharedPreferences
  });

  test('Draft should have default values when not provided', () {
    final Draft draft = Draft();

    expect(draft.id, isNotEmpty); // Should generate a unique ID
    expect(draft.employee, 'Especifica tu nombre');
    expect(draft.duration, '0');
    expect(draft.creationDate, isNotEmpty);
    expect(draft.state, DraftState.notCompleted);
    expect(draft.products, isEmpty);
    expect(draft.observations, '');
  });

  test('Draft should correctly convert to JSON', () {
    final Draft draft = Draft(
      id: '123',
      employee: 'John Doe',
      duration: '2',
      creationDate: '2023-08-10T12:00:00Z',
      state: DraftState.completed,
      products: <Product>[Product(id: '1', name: 'Product 1', stockAnterior: 10, state: ProductState.unchecked)],
      observations: 'Some notes',
    );

    final Map<String, dynamic> json = draft.toJson();

    expect(json['id'], '123');
    expect(json['employee'], 'John Doe');
    expect(json['duration'], '2');
    expect(json['creationDate'], '2023-08-10T12:00:00Z');
    expect(json['state'], DraftState.completed.index);
    expect(json['products'], isNotEmpty);
    expect(json['observations'], 'Some notes');
  });

  test('Draft should save and load correctly from SharedPreferences', () async {
    final Draft draft = Draft(
      id: '123',
      employee: 'John Doe',
      duration: '2',
      creationDate: '2023-08-10T12:00:00Z',
      state: DraftState.completed,
      products: <Product>[Product(id: '1', name: 'Product 1', stockAnterior: 10, state: ProductState.unchecked)],
      observations: 'Some notes',
    );

    await draft.saveDraft();

    final List<Draft> loadedDrafts = await Draft.loadDrafts();

    expect(loadedDrafts.length, 1);
    expect(loadedDrafts.first.id, '123');
    expect(loadedDrafts.first.employee, 'John Doe');
  });

  test('Draft should update an existing draft in SharedPreferences', () async {
    final Draft draft1 = Draft(id: '123', employee: 'John Doe');
    await draft1.saveDraft();

    final Draft draft2 = Draft(id: '123', employee: 'Jane Smith');
    await draft2.saveDraft();

    final List<Draft> loadedDrafts = await Draft.loadDrafts();

    expect(loadedDrafts.length, 1);
    expect(loadedDrafts.first.employee, 'Jane Smith');
  });
}
