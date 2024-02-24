import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlocken/AboutMe/about_me_table.dart';
import 'package:jotrockenmitlocken/AboutMe/perfect_day_chart.dart';
import 'package:jotrockenmitlocken/AboutMe/skill_table.dart';
import 'package:jotrockenmitlocken/Blog/blog.dart';
import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/DocumentPage/document_table.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Media/markdown_page.dart';
import 'package:jotrockenmitlocken/Media/quotes_list.dart';

import 'package:jotrockenmitlocken/footer.dart';
import 'package:jotrockenmitlocken/home.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/Layout/vertical_scroll_page.dart';

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

  GoRoute buildGoRouteForSPA(String path, Widget child) {
    return GoRoute(
        path: path,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: child,
          );
        });
  }

  List<List<Widget>> createHomeChildPages(
      bool useOtherLanguageMode, ColorSeed colorSelected) {
    const colDivider = SizedBox(height: 10);
    List<Widget> childWidgetsLeftPage = [
      colDivider,
      AIPlayground(
        colorSelected: colorSelected,
      ),
      colDivider,
    ];
    List<Widget> childWidgetsRightPage = [
      colDivider,
      RenderingPlayground(
        colorSelected: colorSelected,
      ),
    ];
    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  List<List<Widget>> createAboutMeChildPages(
      bool useOtherLanguageMode, ColorSeed colorSelected) {
    const colDivider = SizedBox(height: 10);
    List<Widget> childWidgetsLeftPage = [
      AboutMeTable(
          useOtherLanguageMode: useOtherLanguageMode,
          colorSelected: colorSelected),
    ];
    double marginSkillTable = 0;
    double paddingSkillTable = 5;

    List<Widget> childWidgetsRightPage = [
      const PerfectDay(),
      const SizedBox(
        height: 40,
      ),
      applyBoxDecoration(
          SkillTable(
            useOtherLanguageMode: useOtherLanguageMode,
          ),
          EdgeInsets.all(paddingSkillTable),
          marginSkillTable,
          30,
          5,
          colorSelected.color),
    ];

    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  List<StatefulShellBranch> createFooterBranches(
      bool showMediumSizeLayout, bool showLargeSizeLayout) {
    var imprint = LayoutManager.createSinglePage([
      MarkdownFilePage(
        filePathDe: 'assets/documents/footer/imprintDe.md',
        filePathEn: 'assets/documents/footer/imprintEn.md',
      )
    ], showMediumSizeLayout, showLargeSizeLayout);

    var contact = LayoutManager.createSinglePage([
      MarkdownFilePage(
        filePathDe: 'assets/documents/footer/contactDe.md',
        filePathEn: 'assets/documents/footer/contactEn.md',
      )
    ], showMediumSizeLayout, showLargeSizeLayout);

    var privacyPolicy = LayoutManager.createSinglePage([
      MarkdownFilePage(
        filePathDe: 'assets/documents/footer/privacyPolicyDe.md',
        filePathEn: 'assets/documents/footer/privacyPolicyEn.md',
      )
    ], showMediumSizeLayout, showLargeSizeLayout);

    var cookieStatement = LayoutManager.createSinglePage([
      MarkdownFilePage(
        filePathDe: 'assets/documents/footer/cookieDeclarationDe.md',
        filePathEn: 'assets/documents/footer/cookieDeclarationEn.md',
      )
    ], showMediumSizeLayout, showLargeSizeLayout);

    var declarationOnAccessibility = LayoutManager.createSinglePage([
      MarkdownFilePage(
        filePathDe: 'assets/documents/footer/declarationOnAccessibilityDe.md',
        filePathEn: 'assets/documents/footer/declarationOnAccessibilityEn.md',
      )
    ], showMediumSizeLayout, showLargeSizeLayout);
    return [
      StatefulShellBranch(
        routes: <RouteBase>[
          buildGoRouteForSPA('/imprint', imprint),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          buildGoRouteForSPA('/contact', contact),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          buildGoRouteForSPA('/privacyPolicy', privacyPolicy),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          buildGoRouteForSPA('/cookieStatement', cookieStatement),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          buildGoRouteForSPA(
              '/declarationOnAccessibility', declarationOnAccessibility),
        ],
      ),
    ];
  }

  List<StatefulShellBranch> createNavBarBranches(
      bool showMediumSizeLayout, bool showLargeSizeLayout) {
    var aboutMePagesLeftRight = createAboutMeChildPages(
        widget.useOtherLanguageMode, widget.colorSelected);
    var homePagesLeftRight =
        createHomeChildPages(widget.useOtherLanguageMode, widget.colorSelected);
    // The route branch for the first tab of the bottom navigation bar.
    return [
      StatefulShellBranch(
        navigatorKey: _sectionNavigatorKey,
        routes: <RouteBase>[
          buildGoRouteForSPA(
              '/home',
              LayoutManager.createOneTwoTransisionWidget(
                  homePagesLeftRight[0],
                  homePagesLeftRight[1],
                  showMediumSizeLayout,
                  showLargeSizeLayout,
                  railAnimation)),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          buildGoRouteForSPA(
              '/aboutMe',
              LayoutManager.createOneTwoTransisionWidget(
                  aboutMePagesLeftRight[0],
                  aboutMePagesLeftRight[1],
                  showMediumSizeLayout,
                  showLargeSizeLayout,
                  railAnimation)),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          buildGoRouteForSPA(
              '/quotations',
              LayoutManager.createSinglePage([
                QuotesList(
                  colorSelected: widget.colorSelected,
                ),
              ], showMediumSizeLayout, showLargeSizeLayout)),
        ],
      ),
      StatefulShellBranch(
        // It's not necessary to provide a navigatorKey if it isn't also
        // needed elsewhere. If not provided, a default key will be used.
        routes: <RouteBase>[
          buildGoRouteForSPA(
              '/documents',
              LayoutManager.createSinglePage([
                DocumentTable(
                  colorSelected: widget.colorSelected,
                )
              ], showMediumSizeLayout, showLargeSizeLayout)),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
            branches: createNavBarBranches(
                    showMediumSizeLayout, showLargeSizeLayout) +
                createFooterBranches(showMediumSizeLayout, showLargeSizeLayout),
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
