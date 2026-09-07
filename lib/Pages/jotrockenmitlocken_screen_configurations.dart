import 'package:anthology/l10n/anthology_localizations.dart';
import 'package:flutter/material.dart';

import 'package:anthology/Pages/ErrorPage/error_page_stateful_branch_info_provider.dart';
import 'package:anthology/Pages/Footer/generic_footer_page_config.dart';
import 'package:anthology/Pages/generic_navbar_page_config.dart';
import 'package:anthology/Pages/Sqlite/sqlite_test_page_config.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:anthology/Pages/simple_page_config.dart';
import 'package:anthology/Pages/blog_dependent_screen_configurations.dart';
import 'package:anthology/blog_page_config.dart';
import 'package:anthology/Pages/Footer/footer_page_config.dart';
import 'package:anthology/my_two_cents_config.dart';
import 'package:anthology/Pages/navbar_page_config.dart';
import 'package:anthology/Pages/stateful_branch_info_provider.dart';
import 'package:anthology/Routing/screen_configurations.dart';

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
        headingBuilder: (context) =>
            AnthologyLocalizations.of(context)!.imprint,
        filePathDe: 'packages/anthology/assets/documents/footer/imprintDe.md',
        filePathEn: 'packages/anthology/assets/documents/footer/imprintEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/contact',
        headingBuilder: (context) =>
            AnthologyLocalizations.of(context)!.contact,
        filePathDe: 'packages/anthology/assets/documents/footer/contactDe.md',
        filePathEn: 'packages/anthology/assets/documents/footer/contactEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/privacyPolicy',
        headingBuilder: (context) =>
            AnthologyLocalizations.of(context)!.privacyPolicy,
        filePathDe:
            'packages/anthology/assets/documents/footer/privacyPolicyDe.md',
        filePathEn:
            'packages/anthology/assets/documents/footer/privacyPolicyEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/cookieDeclaration',
        headingBuilder: (context) =>
            AnthologyLocalizations.of(context)!.cookieStatement,
        filePathDe:
            'packages/anthology/assets/documents/footer/cookieDeclarationDe.md',
        filePathEn:
            'packages/anthology/assets/documents/footer/cookieDeclarationEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/declarationOnAccessibility',
        headingBuilder: (context) =>
            AnthologyLocalizations.of(context)!.declarationOnAccessibility,
        filePathDe:
            'packages/anthology/assets/documents/footer/declarationOnAccessibilityDe.md',
        filePathEn:
            'packages/anthology/assets/documents/footer/declarationOnAccessibilityEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/copyright',
        headingBuilder: (context) =>
            AnthologyLocalizations.of(context)!.copyrightFooterTitle,
        filePathDe: 'packages/anthology/assets/documents/footer/copyRightDe.md',
        filePathEn: 'packages/anthology/assets/documents/footer/copyRightEn.md',
      ),
      GenericFooterPageConfig(
        routingName: '/openSourceLicenses',
        headingBuilder: (context) =>
            AnthologyLocalizations.of(context)!.openSourceLicenses,
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
