import 'package:flutter/material.dart';

const String appTitle = 'Artificial neurons are almost magic';

// NavigationRail shows if the screen width is greater or equal to
// narrowScreenWidthThreshold; otherwise, NavigationBar is used for navigation.
const double narrowScreenWidthThreshold = 450;

const double mediumWidthBreakpoint = 1000;
const double largeWidthBreakpoint = 1500;

const double transitionLength = 500;

const appName = "Jotrockenmitlocken";

enum ColorSeed {
  baseColor('Green Accent', Colors.greenAccent),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

enum ScreenSelected {
  home(0),
  aboutMe(1),
  quotations(2),
  documents(3);

  const ScreenSelected(this.value);
  final int value;
}

enum NonNavBarScreenSelected {
  imprint(0),
  contact(1),
  privacyPolicy(2),
  cookieDeclaration(3),
  declarationOnAccessibility(4);

  const NonNavBarScreenSelected(this.value);
  final int value;
}

const supportedLanguages = [
  Locale('de'), // Deutsch
  Locale('en'), // English
];

const baseDocumentDir = 'https://www.jonasheinle.de/assets/assets/documents/';
