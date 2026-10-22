@TestOn('vm')
library;

import 'package:anthology_test_support/app_contracts.dart';
import 'package:flutter_test/flutter_test.dart' show TestOn;
import 'package:jotrockenmitlocken/main.dart';

void main() {
  registerAppLayoutTests(
    app: () => const App(),
    routes: const <String>[
      '/landingPage',
      '/aboutMe',
      '/data',
      '/documents',
      '/privacyPolicy',
      '/openSourceLicenses',
      '/aiBlog',
      '/sqliteTest',
      '/quotations',
      '/books',
      '/films',
      '/games',
      '/blockEntries',
    ],
  );
  registerAppNavigationContract(
    app: () => const App(),
    navigationIndex: 1,
    route: '/aboutMe',
  );
}
