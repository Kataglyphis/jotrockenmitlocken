import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:jotrockenmitlocken/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App smoke tests', () {
    testWidgets('app boots without errors', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('landing page renders', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      expect(find.text('Jonas'), findsWidgets);
    });

    testWidgets('navigation rail renders', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      expect(find.byType(NavigationRail), findsOneWidget);
    });
  });
}
