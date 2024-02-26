// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/Pages/Home/home.dart';
import 'package:jotrockenmitlocken/main.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';

void main() {
  testWidgets('# of screens must be the same as the # of nav bar items',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    final BuildContext context = tester.element(find.byType(Home));
  });
}
