import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'steps/inventory_management_steps.dart';

void main() {
  final FlutterTestConfiguration config = FlutterTestConfiguration()
    ..features = <Pattern>[
      './test_driver/features/inventory_management.feature'
    ]
    ..reporters = <Reporter>[
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_driver/report.json')
    ]
    ..stepDefinitions = <StepDefinitionGeneric<World>>[
      IAmOnPage(),
      IShouldSeeText(),
      ITapOn(),
      IChangeStockTo(),
      ITapOutsideTextField(),
      IShouldBeOnScreen(),
      IChangeInventoryManagerName(),
      IShouldSeeMessage(),
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart'; 

  GherkinRunner().execute(config);
}
