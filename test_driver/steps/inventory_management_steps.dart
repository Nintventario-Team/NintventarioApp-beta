import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';

class IAmOnPage extends Given1WithWorld<String, FlutterWorld> {
  IAmOnPage()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String page) async {
    // Checking based on the presence of expected text on the screen
    switch (page) {
      case 'Home':
        await FlutterDriverUtils.waitForFlutter(world.driver);
        await FlutterDriverUtils.isPresent(find.text('HOME') as FlutterDriver?, world.driver as SerializableFinder);
        break;
      case 'Product List':
        await FlutterDriverUtils.waitForFlutter(world.driver);
        await FlutterDriverUtils.isPresent(find.text('Lista de productos') as FlutterDriver?, world.driver as SerializableFinder);
        break;
      case 'Product Details':
        await FlutterDriverUtils.waitForFlutter(world.driver);
        await FlutterDriverUtils.isPresent(find.text('Detalles del producto') as FlutterDriver?, world.driver as SerializableFinder);
        break;
      case 'Inventory Details':
        await FlutterDriverUtils.waitForFlutter(world.driver);
        await FlutterDriverUtils.isPresent(find.text('Detalles del Inventario') as FlutterDriver?, world.driver as SerializableFinder);
        break;
      default:
        throw Exception('Page not found: $page');
    }
  }

  @override
  RegExp get pattern => RegExp(r'I am on the {string} page');
}

class IShouldSeeText extends Then1WithWorld<String, FlutterWorld> {
  IShouldSeeText()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String text) async {
    final bool isPresent = await FlutterDriverUtils.isPresent(find.text(text) as FlutterDriver?, world.driver as SerializableFinder);
    expect(isPresent, true, reason: 'Expected to see text $text but did not find it.');
  }

  @override
  RegExp get pattern => RegExp(r'I should see the text {string}');
}

class ITapOn extends When1WithWorld<String, FlutterWorld> {
  ITapOn()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String target) async {
    await FlutterDriverUtils.tap(world.driver, find.text(target));
  }

  @override
  RegExp get pattern => RegExp(r'I tap on the {string}');
}

class IChangeStockTo extends When1WithWorld<String, FlutterWorld> {
  IChangeStockTo()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String stock) async {
    final SerializableFinder textField = find.byType('TextField'); // Assuming it's the first TextField on the screen
    await FlutterDriverUtils.tap(world.driver, textField);
    await FlutterDriverUtils.enterText(world.driver, textField, stock);
  }

  @override
  RegExp get pattern => RegExp(r'I change the stock to {string}');
}

class ITapOutsideTextField extends AndWithWorld<FlutterWorld> {
  ITapOutsideTextField()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    // Tapping on the first non-TextField element, assuming it's safe to do so
    final SerializableFinder outside = find.byType('Scaffold'); // Or just find.anything();
    await FlutterDriverUtils.tap(world.driver, outside);
  }

  @override
  RegExp get pattern => RegExp(r'I tap outside the TextField');
}

class IShouldBeOnScreen extends Then1WithWorld<String, FlutterWorld> {
  IShouldBeOnScreen()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String screen) async {
    final bool isPresent = await FlutterDriverUtils.isPresent(find.text(screen) as FlutterDriver?, world.driver as SerializableFinder);
    expect(isPresent, true, reason: 'Expected to be on screen $screen but did not find it.');
  }

  @override
  RegExp get pattern => RegExp(r'I should be on the {string} screen');
}

class IChangeInventoryManagerName extends When1WithWorld<String, FlutterWorld> {
  IChangeInventoryManagerName()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String name) async {
    final SerializableFinder textField = find.byType('TextField'); // Assuming it's the first TextField
    await FlutterDriverUtils.tap(world.driver, textField);
    await FlutterDriverUtils.enterText(world.driver, textField, name);
  }

  @override
  RegExp get pattern => RegExp(r'I change the inventory manager name to {string}');
}

class IShouldSeeMessage extends Then1WithWorld<String, FlutterWorld> {
  IShouldSeeMessage()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  Future<void> executeStep(String message) async {
    final bool isPresent = await FlutterDriverUtils.isPresent(find.text(message) as FlutterDriver?, world.driver as SerializableFinder);
    expect(isPresent, true, reason: 'Expected to see message $message but did not find it.');
  }

  @override
  RegExp get pattern => RegExp(r'I should see the {string} message');
}
