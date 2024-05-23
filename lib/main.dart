// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:go_router/go_router.dart';

import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Routing/jotrockenmitlocken_router.dart';
import 'package:jotrockenmitlocken/Pages/Home/home_config.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlocken/blog_dependent_app_attributes.dart';
import 'package:jotrockenmitlocken/blog_page_config.dart';
import 'package:jotrockenmitlocken/my_two_cents_config.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/app_settings.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:jotrockenmitlockenrepo/Routing/router_creater.dart';
import 'package:jotrockenmitlockenrepo/user_settings.dart';

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

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  ThemeMode themeMode = ThemeMode.dark;
  ColorSeed colorSelected = ColorSeed.baseColor;
  bool useOtherLanguageMode = false;

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

  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
  late Future<
      (
        AppSettings,
        UserSettings,
        List<BlogPageConfig>,
        List<MyTwoCentsConfig>
      )> _settings;
  final String userSettingsFilePath =
      "assets/settings/user_settings/global_user_settings.json";
  final String appSettingsFilePath = "assets/settings/app_settings.json";
  final String blogSettingsFilePath = "assets/settings/blog_settings.json";
  final String twoCentsSettingsFilePath =
      "assets/settings/my_two_cents_settings.json";
  bool controllerInitialized = false;
  bool showMediumSizeLayout = false;
  bool showLargeSizeLayout = false;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: transitionLength.toInt() * 2),
      value: 0,
      vsync: this,
    );
    railAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0),
    );
    _settings = _loadAppSettings();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = controller.status;
    if (width > mediumWidthBreakpoint) {
      if (width > largeWidthBreakpoint) {
        showMediumSizeLayout = false;
        showLargeSizeLayout = true;
      } else {
        showMediumSizeLayout = true;
        showLargeSizeLayout = false;
      }
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        controller.forward();
      }
    } else {
      showMediumSizeLayout = false;
      showLargeSizeLayout = false;
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      controller.value = width > mediumWidthBreakpoint ? 1 : 0;
    }
  }

  Future<
      (
        AppSettings,
        UserSettings,
        List<BlogPageConfig>,
        List<MyTwoCentsConfig>
      )> _loadAppSettings() async {
    final userSettingsJsonString =
        await rootBundle.loadString(userSettingsFilePath);
    final Map<String, dynamic> userSettingsJson =
        json.decode(userSettingsJsonString);
    UserSettings userSettings = UserSettings.fromJsonFile(userSettingsJson);

    final appSettingsJsonString =
        await rootBundle.loadString(appSettingsFilePath);
    final Map<String, dynamic> appSettingsJson =
        json.decode(appSettingsJsonString);
    AppSettings appSettings = AppSettings.fromJsonFile(appSettingsJson);

    final blogSettingsJsonString =
        await rootBundle.loadString(blogSettingsFilePath);
    final List<dynamic> blogSettingsJson = json.decode(blogSettingsJsonString);
    List<BlogPageConfig> blogConfigs = [];
    for (var e in blogSettingsJson) {
      blogConfigs.add(BlogPageConfig.fromJsonFile(e as Map<String, dynamic>));
    }

    final twoCentsSettingsJsonString =
        await rootBundle.loadString(twoCentsSettingsFilePath);
    final List<dynamic> twoCentsSettingsJson =
        json.decode(twoCentsSettingsJsonString);
    List<MyTwoCentsConfig> twoCentsConfigs = [];
    for (var e in twoCentsSettingsJson) {
      twoCentsConfigs
          .add(MyTwoCentsConfig.fromJsonFile(e as Map<String, dynamic>));
    }
    return (appSettings, userSettings, blogConfigs, twoCentsConfigs);
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleLanguageChange() {
    setState(() {
      useOtherLanguageMode = useOtherLanguageMode ? false : true;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = ColorSeed.values[value];
    });
  }

  final List<LocalizationsDelegate> localizationsDelegate = const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  @override
  Widget build(BuildContext context) {
    ThemeData darkTheme = ThemeData(
      fontFamily: 'Roboto',
      colorSchemeSeed: colorSelected.color,
      useMaterial3: true,
      brightness: Brightness.dark,
    );
    ThemeData lightTheme = ThemeData(
      fontFamily: 'Roboto',
      colorSchemeSeed: colorSelected.color,
      useMaterial3: true,
      brightness: Brightness.light,
    );
    return FutureBuilder(
        future: _settings,
        builder: (context, data) {
          if (data.hasData) {
            JotrockenmitLockenScreenConfigurations screenConfigurations =
                JotrockenmitLockenScreenConfigurations.fromBlogAndDataConfigs(
                    blogPageConfigs: data.requireData.$3,
                    twoCentsConfigs: data.requireData.$4);
            BlogDependentAppAttributes blogDependentAppAttributes =
                BlogDependentAppAttributes(
                    blogDependentScreenConfigurations: screenConfigurations,
                    twoCentsConfigs: data.requireData.$4,
                    blockSettings: data.requireData.$3);
            AppAttributes appAttributes = AppAttributes(
              footerConfig: JoTrockenMitLockenFooterConfig(),
              homeConfig: JotrockenMitLockenHomeConfig(),
              appSettings: data.requireData.$1,
              userSettings: data.requireData.$2,
              screenConfigurations: screenConfigurations,
              railAnimation: railAnimation,
              showMediumSizeLayout: showMediumSizeLayout,
              showLargeSizeLayout: showLargeSizeLayout,
              useOtherLanguageMode: useOtherLanguageMode,
              useLightMode: useLightMode,
              colorSelected: colorSelected,
              handleBrightnessChange: handleBrightnessChange,
              handleLanguageChange: handleLanguageChange,
              handleColorSelect: handleColorSelect,
            );

            RoutesCreator routesCreator = JotrockenMitLockenRoutes(
                blogDependentAppAttributes: blogDependentAppAttributes);

            final GoRouter routerConfig = routesCreator.getRouterConfig(
              appAttributes,
              controller,
            );
            var supportedLanguages = data.requireData.$1.supportedLocales!
                .map((element) => Locale(element))
                .toList();
            return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: localizationsDelegate,
                onGenerateTitle: (context) =>
                    (Localizations.localeOf(context) == const Locale("de"))
                        ? appAttributes.appSettings.appTitleDe
                        : appAttributes.appSettings.appTitleEn,
                themeMode: themeMode,
                locale: supportedLanguages[0],
                supportedLocales: supportedLanguages,
                theme: lightTheme,
                darkTheme: darkTheme,
                routerConfig: routerConfig);
          } else if (data.hasError) {
            return Text("${data.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: ColorSeed.baseColor.color,
              ),
            );
          }
        });
  }
}
