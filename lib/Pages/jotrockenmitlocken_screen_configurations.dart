import 'package:flutter/material.dart';

import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page_stateful_branch_info_provider.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/generic_footer_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/generic_navbar_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Sqlite/sqlite_test_page_config.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Pages/simple_page_config.dart';
import 'package:jotrockenmitlocken/Pages/blog_dependent_screen_configurations.dart';
import 'package:jotrockenmitlocken/blog_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_page_config.dart';
import 'package:jotrockenmitlocken/my_two_cents_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';
import 'package:jotrockenmitlockenrepo/Routing/screen_configurations.dart';

class JotrockenmitLockenScreenConfigurations extends ScreenConfigurations
    with BlogDependentScreenConfigurations {
  List<BlogPageConfig> blogPageConfigs;
  List<MyTwoCentsConfig> twoCentsConfigs;
  JotrockenmitLockenScreenConfigurations.fromBlogAndDataConfigs({
    required this.blogPageConfigs,
    required this.twoCentsConfigs,
  });

  @override
  List<StatefulBranchInfoProvider> getAllPagesConfigs() {
    List<StatefulBranchInfoProvider> pagesConfigs = [];
    for (StatefulBranchInfoProvider navRailPageConfig
        in getNavRailPagesConfig()) {
      pagesConfigs.add(navRailPageConfig);
    }
    for (StatefulBranchInfoProvider navRailPageConfig
        in getFooterPagesConfig()) {
      pagesConfigs.add(navRailPageConfig);
    }
    for (StatefulBranchInfoProvider blogPageConfig in getBlogPagesConfig()) {
      pagesConfigs.add(blogPageConfig);
    }
    for (StatefulBranchInfoProvider mediaCriticsPageConfig
        in getMediaCriticsPagesConfig()) {
      pagesConfigs.add(mediaCriticsPageConfig);
    }
    for (StatefulBranchInfoProvider errorPageConfig in getErrorPagesConfig()) {
      pagesConfigs.add(errorPageConfig);
    }
    for (StatefulBranchInfoProvider dataPageConfig in getDataPagesConfig()) {
      pagesConfigs.add(dataPageConfig);
    }
    return pagesConfigs;
  }

  @override
  List<NavBarPageConfig> getNavRailPagesConfig() {
    return [
      GenericNavBarPageConfig(
        icon: Icons.house_outlined,
        selectedIcon: Icons.house,
        labelBuilder: (context) => AppLocalizations.of(context)!.homepage,
        routingName: '/landingPage',
      ),
      GenericNavBarPageConfig(
        icon: Icons.person_outlined,
        selectedIcon: Icons.person,
        labelBuilder: (context) => AppLocalizations.of(context)!.aboutme,
        routingName: '/aboutMe',
      ),
      GenericNavBarPageConfig(
        icon: Icons.folder_open_outlined,
        selectedIcon: Icons.folder_open,
        labelBuilder: (context) => AppLocalizations.of(context)!.data,
        routingName: '/data',
      ),
      GenericNavBarPageConfig(
        icon: Icons.description_outlined,
        selectedIcon: Icons.description,
        labelBuilder: (context) => AppLocalizations.of(context)!.documents,
        routingName: '/documents',
      ),
    ];
  }

  @override
  List<StatefulBranchInfoProvider> getErrorPagesConfig() {
    return [ErrorPageStatefulBranchInfoProvider()];
  }

  @override
  List<FooterPageConfig> getFooterPagesConfig() {
    return [
      GenericFooterPageConfig(
        routingName: '/imprint',
        headingBuilder: (context) => AppLocalizations.of(context)!.imprint,
        filePathDe: 'assets/documents/footer/imprintDe.md',
        filePathEn: 'assets/documents/footer/imprintEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/contact',
        headingBuilder: (context) => AppLocalizations.of(context)!.contact,
        filePathDe: 'assets/documents/footer/contactDe.md',
        filePathEn: 'assets/documents/footer/contactEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/privacyPolicy',
        headingBuilder: (context) =>
            AppLocalizations.of(context)!.privacyPolicy,
        filePathDe: 'assets/documents/footer/privacyPolicyDe.md',
        filePathEn: 'assets/documents/footer/privacyPolicyEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/cookieDeclaration',
        headingBuilder: (context) =>
            AppLocalizations.of(context)!.cookieStatement,
        filePathDe: 'assets/documents/footer/cookieDeclarationDe.md',
        filePathEn: 'assets/documents/footer/cookieDeclarationEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/declarationOnAccessibility',
        headingBuilder: (context) =>
            AppLocalizations.of(context)!.declarationOnAccessibility,
        filePathDe: 'assets/documents/footer/declarationOnAccessibilityDe.md',
        filePathEn: 'assets/documents/footer/declarationOnAccessibilityEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/copyright',
        headingBuilder: (context) =>
            AppLocalizations.of(context)!.copyrightFooterTitle,
        filePathDe: 'assets/documents/footer/copyRightDe.md',
        filePathEn: 'assets/documents/footer/copyRightEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/openSourceLicenses',
        headingBuilder: (context) =>
            AppLocalizations.of(context)!.openSourceLicenses,
        filePathDe: '',
        filePathEn: '',
      ),
    ];
  }

  // from here on everything is blog dependend
  @override
  List<BlogPageConfig> getBlogPagesConfig() {
    return blogPageConfigs;
  }

  @override
  List<MyTwoCentsConfig> getMediaCriticsPagesConfig() {
    return twoCentsConfigs;
  }

  @override
  List<StatefulBranchInfoProvider> getDataPagesConfig() {
    return [
      const SimplePageConfig('/quotations'),
      const SimplePageConfig('/books'),
      const SimplePageConfig('/films'),
      const SimplePageConfig('/games'),
      const SimplePageConfig('/blockEntries'),
      const SqliteTestPageConfig(),
    ];
  }
}
