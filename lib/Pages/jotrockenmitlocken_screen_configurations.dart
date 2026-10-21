import 'package:flutter/material.dart';

import 'package:anthology/Pages/ErrorPage/error_page_stateful_branch_info_provider.dart';
import 'package:anthology/Pages/Footer/default_footer_pages.dart';
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
  List<FooterPageConfig> getFooterPagesConfig() => defaultFooterPageConfigs();

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
