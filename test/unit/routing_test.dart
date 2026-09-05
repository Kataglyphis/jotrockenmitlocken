import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlocken/Routing/jotrockenmitlocken_router.dart';
import 'package:jotrockenmitlocken/blog_dependent_app_attributes.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:anthology/Pages/Footer/footer.dart';
import 'package:anthology/Pages/Footer/footer_config.dart';
import 'package:anthology/Pages/Home/button_names.dart';
import 'package:anthology/Pages/Home/home_config.dart';
import 'package:anthology/Pages/generic_navbar_page_config.dart';
import 'package:anthology/Url/external_link_config.dart';
import 'package:anthology/app_attributes.dart';
import 'package:anthology/app_settings.dart';
import 'package:anthology/constants.dart';
import 'package:anthology/user_settings.dart';

class _TestFooterConfig extends FooterConfig {
  @override
  String getLiabilityText(BuildContext context) => 'liability';
  @override
  String getExternalLinksTitle(BuildContext context) => 'links';
  @override
  List<ExternalLinkConfig> getExternalLinks(BuildContext context) => [];
}

class _TestHomeConfig extends HomeConfig {
  @override
  ButtonNames getButtonNames(BuildContext context) => ButtonNames();
}

AppAttributes _createAppAttributes({
  required JotrockenmitLockenScreenConfigurations screenConfigurations,
  required CurvedAnimation railAnimation,
}) {
  return AppAttributes(
    footerConfig: _TestFooterConfig(),
    homeConfig: _TestHomeConfig(),
    appSettings: AppSettings(
      appNameDe: 'TestDE',
      appNameEn: 'TestEN',
      appTitleDe: 'TitleDE',
      appTitleEn: 'TitleEN',
      disableFooter: false,
    ),
    userSettings: UserSettings(
      socialMediaLinksConfig: <String, ExternalLinkConfig>{},
      businessEmail: 'test@example.com',
      myQuotation: 'Hello',
      firstName: 'Jane',
      lastName: 'Doe',
      aboutMeFileDe: 'about_de.md',
      aboutMeFileEn: 'about_en.md',
      assetPathImgOfMe: 'img.jpg',
    ),
    screenConfigurations: screenConfigurations,
    railAnimation: railAnimation,
    showMediumSizeLayout: false,
    showLargeSizeLayout: false,
    colorSelected: ColorSeed.baseColor,
    useLightMode: true,
  );
}

BlogDependentAppAttributes _createBlogDependentAppAttributes({
  required JotrockenmitLockenScreenConfigurations screenConfigurations,
}) {
  return BlogDependentAppAttributes(
    blogDependentScreenConfigurations: screenConfigurations,
    twoCentsConfigs: [],
    blockSettings: [],
  );
}

void main() {
  group('JotrockenMitLockenRoutes', () {
    late JotrockenmitLockenScreenConfigurations screenConfigurations;
    late CurvedAnimation railAnimation;
    late AnimationController animationController;

    setUp(() {
      // CurvedAnimation requires a TickerProvider, available via TestVSync
      // from the widget test binding.
      final vsync = TestVSync();
      animationController = AnimationController(vsync: vsync);
      railAnimation = CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      );

      screenConfigurations =
          JotrockenmitLockenScreenConfigurations.fromBlogAndDataConfigs(
            blogPageConfigs: [],
            twoCentsConfigs: [],
          );
    });

    tearDown(() {
      animationController.dispose();
    });

    test('constructs with minimal BlogDependentAppAttributes', () {
      final blogAttrs = _createBlogDependentAppAttributes(
        screenConfigurations: screenConfigurations,
      );

      final routes = JotrockenMitLockenRoutes(
        blogDependentAppAttributes: blogAttrs,
      );

      expect(routes, isNotNull);
      expect(routes.blogDependentAppAttributes, same(blogAttrs));
    });

    test(
      'getAllPagesWithConfigs returns correct number of page+config tuples',
      () {
        final blogAttrs = _createBlogDependentAppAttributes(
          screenConfigurations: screenConfigurations,
        );
        final routes = JotrockenMitLockenRoutes(
          blogDependentAppAttributes: blogAttrs,
        );
        final appAttributes = _createAppAttributes(
          screenConfigurations: screenConfigurations,
          railAnimation: railAnimation,
        );

        final allPages = routes.getAllPagesWithConfigs(appAttributes);

        // 4 navbar + 7 footer + 0 blog + 6 data + 0 media + 1 error = 18
        expect(allPages.length, 18);
      },
    );

    test('getFooter returns Footer widget', () {
      final blogAttrs = _createBlogDependentAppAttributes(
        screenConfigurations: screenConfigurations,
      );
      final routes = JotrockenMitLockenRoutes(
        blogDependentAppAttributes: blogAttrs,
      );
      final appAttributes = _createAppAttributes(
        screenConfigurations: screenConfigurations,
        railAnimation: railAnimation,
      );

      final footer = routes.getFooter(appAttributes);

      expect(footer, isA<Footer>());
    });

    test('all routing names are unique (no duplicates)', () {
      final blogAttrs = _createBlogDependentAppAttributes(
        screenConfigurations: screenConfigurations,
      );
      final routes = JotrockenMitLockenRoutes(
        blogDependentAppAttributes: blogAttrs,
      );
      final appAttributes = _createAppAttributes(
        screenConfigurations: screenConfigurations,
        railAnimation: railAnimation,
      );

      final allPages = routes.getAllPagesWithConfigs(appAttributes);
      final routingNames = allPages
          .map((tuple) => tuple.$2.getRoutingName())
          .toList();

      expect(
        routingNames.toSet().length,
        routingNames.length,
        reason: 'Duplicate routing names found: $routingNames',
      );
    });
  });

  group('GenericNavBarPageConfig', () {
    testWidgets('labelBuilder produces correct string from AppLocalizations', (
      tester,
    ) async {
      final config = GenericNavBarPageConfig(
        icon: Icons.home,
        selectedIcon: Icons.home_filled,
        labelBuilder: (context) => AppLocalizations.of(context)!.homepage,
        routingName: '/home',
      );

      String? label;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              label = config.labelBuilder(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(label, 'Homepage');
    });

    testWidgets('labelBuilder works with different getter', (tester) async {
      final config = GenericNavBarPageConfig(
        icon: Icons.person,
        selectedIcon: Icons.person_outlined,
        labelBuilder: (context) => AppLocalizations.of(context)!.aboutme,
        routingName: '/about',
      );

      String? label;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              label = config.labelBuilder(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(label, 'About me');
    });

    testWidgets('getNavigationDestination returns NavigationDestination '
        'with correct icon/label', (tester) async {
      final config = GenericNavBarPageConfig(
        icon: Icons.folder_open_outlined,
        selectedIcon: Icons.folder_open,
        labelBuilder: (context) => AppLocalizations.of(context)!.data,
        routingName: '/data',
      );

      NavigationDestination? captured;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              captured = config.getNavigationDestination(context);
              return Scaffold(
                body: NavigationBar(
                  destinations: [
                    captured!,
                    const NavigationDestination(
                      icon: Icon(Icons.abc),
                      label: 'Placeholder',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('Data'), findsOneWidget);
      expect(captured, isNotNull);
      expect(captured!.label, 'Data');
    });

    test('getRoutingName returns configured value', () {
      final config = GenericNavBarPageConfig(
        icon: Icons.home,
        selectedIcon: Icons.home_filled,
        labelBuilder: (context) => AppLocalizations.of(context)!.homepage,
        routingName: '/customRoute',
      );

      expect(config.getRoutingName(), '/customRoute');
    });
  });
}
