import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';

import 'package:jotrockenmitlocken/Pages/Home/home.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/routing/router_creater.dart';

class AppFrame extends StatefulWidget {
  const AppFrame({
    super.key,
    required this.useLightMode,
    required this.useOtherLanguageMode,
    required this.colorSelected,
    required this.handleBrightnessChange,
    required this.handleLanguageChange,
    required this.handleColorSelect,
    required this.themeMode,
  });

  final bool useLightMode;
  final bool useOtherLanguageMode;
  final ColorSeed colorSelected;
  final ThemeMode themeMode;

  final void Function() handleLanguageChange;
  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function(int value) handleColorSelect;

  @override
  State<AppFrame> createState() => _AppFrameState();
}

class _AppFrameState extends State<AppFrame>
    with SingleTickerProviderStateMixin {
  // Create keys for `root` & `section` navigator avoiding unnecessary rebuilds
  final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "_rootNavigatorKey");
  final _sectionNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "_sectionNavigatorKey");

  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffoldKey");

  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
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

  @override
  Widget build(BuildContext context) {
    AppFrameAttributes appFrameAttributes = AppFrameAttributes(
        railAnimation: railAnimation,
        showMediumSizeLayout: showMediumSizeLayout,
        showLargeSizeLayout: showLargeSizeLayout,
        useOtherLanguageMode: widget.useOtherLanguageMode,
        colorSelected: widget.colorSelected);
    final GoRouter _routerConfig = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/home',
        routes: <RouteBase>[
          StatefulShellRoute.indexedStack(
            builder: (BuildContext context, GoRouterState state,
                StatefulNavigationShell navigationShell) {
              // Return the widget that implements the custom shell (in this case
              // using a BottomNavigationBar). The StatefulNavigationShell is passed
              // to be able access the state of the shell and to navigate to other
              // branches in a stateful way.
              return Home(
                useLightMode: widget.useLightMode,
                useOtherLanguageMode: widget.useOtherLanguageMode,
                handleBrightnessChange: widget.handleBrightnessChange,
                handleLanguageChange: widget.handleLanguageChange,
                handleColorSelect: widget.handleColorSelect,
                colorSelected: widget.colorSelected,
                showMediumSizeLayout: showMediumSizeLayout,
                showLargeSizeLayout: showLargeSizeLayout,
                controller: controller,
                railAnimation: railAnimation,
                scaffoldKey: scaffoldKey,
                navigationShell: navigationShell,
              );
            },
            branches: RoutesCreator.createNavBarBranches(
                    appFrameAttributes, _sectionNavigatorKey) +
                RoutesCreator.createFooterBranches(appFrameAttributes,
                    showMediumSizeLayout, showLargeSizeLayout),
          )
        ]);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLanguages,
      title: appTitle,
      themeMode: widget.themeMode,
      theme: ThemeData(
        colorSchemeSeed: widget.colorSelected.color,
        colorScheme: null,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: widget.colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      routerConfig: _routerConfig,
    );
  }
}
