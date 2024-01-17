// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'constants.dart';
import 'home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.baseColor;
  bool useOtherLanguageMode = false;
  late Widget home;

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleLanguageChange() {
    setState(() {
      this.useOtherLanguageMode = this.useOtherLanguageMode ? false : true;
      home = Home(
        useLightMode: useLightMode,
        useOtherLanguageMode: useOtherLanguageMode,
        handleBrightnessChange: handleBrightnessChange,
        handleLanguageChange: handleLanguageChange,
        handleColorSelect: handleColorSelect,
        colorSelected: colorSelected,
      );
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = ColorSeed.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    home = Home(
      useLightMode: useLightMode,
      useOtherLanguageMode: useOtherLanguageMode,
      handleBrightnessChange: handleBrightnessChange,
      handleLanguageChange: handleLanguageChange,
      handleColorSelect: handleColorSelect,
      colorSelected: colorSelected,
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('de'), // Deutsch
          Locale('en'), // English
        ],
        title: 'My awesome AI',
        themeMode: themeMode,
        theme: ThemeData(
          colorSchemeSeed: colorSelected.color,
          colorScheme: null,
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: colorSelected.color,
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        home: home);
  }
}
