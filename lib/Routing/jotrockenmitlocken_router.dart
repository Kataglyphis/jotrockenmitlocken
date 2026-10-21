import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/about_me_page.dart';
import 'package:anthology/Pages/DataPage/BlockOverviewPage/block_overview_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BooksPage/books_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/FilmsPage/films_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/GamesPage/games_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/data_page.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/documents_page.dart';
import 'package:anthology/blog_dependent_app_attributes.dart';

import 'package:anthology/Pages/LandingPage/landing_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/QuotesPage/quotes_page.dart';
import 'package:anthology/Pages/Sqlite/sqlite_test_page.dart';
import 'package:anthology/Routing/router_creater.dart';

import 'package:anthology/app_attributes.dart';
import 'package:anthology/Pages/stateful_branch_info_provider.dart';

/// Every jotrockenmitlocken route, each paired with its [StatefulBranchInfoProvider]; the navigation bar's pages first.
class JotrockenMitLockenRoutes extends RoutesCreator {
  final BlogDependentAppAttributes blogDependentAppAttributes;

  JotrockenMitLockenRoutes({required this.blogDependentAppAttributes});

  @override
  List<(Widget, StatefulBranchInfoProvider)> getAllPagesWithConfigs(
    AppAttributes appAttributes,
  ) {
    final screens =
        blogDependentAppAttributes.blogDependentScreenConfigurations;
    return [
      ..._getNavBarPagesAndConfigs(appAttributes),
      ...footerPagesWithConfigs(appAttributes),
      ...blogPagesWithConfigs(appAttributes, screens.getBlogPagesConfig()),
      ..._getDataPagesAndConfigs(appAttributes),
      ...mediaCriticsPagesWithConfigs(
        appAttributes,
        screens.getMediaCriticsPagesConfig(),
      ),
      ...errorPagesWithConfigs(appAttributes),
    ];
  }

  List<(Widget, StatefulBranchInfoProvider)> _getDataPagesAndConfigs(
    AppAttributes appAttributes,
  ) {
    return pairPagesWithConfigs(
      [
        QuotesPage(
          footer: getFooter(appAttributes),
          appAttributes: appAttributes,
        ),
        BooksPage(
          footer: getFooter(appAttributes),
          appAttributes: appAttributes,
          blogDependentAppAttributes: blogDependentAppAttributes,
        ),
        FilmsPage(
          footer: getFooter(appAttributes),
          appAttributes: appAttributes,
        ),
        GamesPage(
          footer: getFooter(appAttributes),
          appAttributes: appAttributes,
          blogDependentAppAttributes: blogDependentAppAttributes,
        ),
        BlockOverviewPage(
          footer: getFooter(appAttributes),
          appAttributes: appAttributes,
          blogDependentAppAttributes: blogDependentAppAttributes,
        ),
        // Labels come from the anthology catalogue, so the fr locale gets French too.
        SqliteTestPage(
          footer: getFooter(appAttributes),
          appAttributes: appAttributes,
        ),
      ],
      blogDependentAppAttributes.blogDependentScreenConfigurations
          .getDataPagesConfig(),
    );
  }

  List<(Widget, StatefulBranchInfoProvider)> _getNavBarPagesAndConfigs(
    AppAttributes appAttributes,
  ) {
    return pairPagesWithConfigs([
      LandingPage(
        footer: getFooter(appAttributes),
        appAttributes: appAttributes,
        blogDependentAppAttributes: blogDependentAppAttributes,
      ),
      AboutMePage(
        footer: getFooter(appAttributes),
        appAttributes: appAttributes,
      ),
      DataPage(footer: getFooter(appAttributes), appAttributes: appAttributes),
      DocumentPage(
        footer: getFooter(appAttributes),
        appAttributes: appAttributes,
      ),
    ], appAttributes.screenConfigurations.getNavRailPagesConfig());
  }
}
