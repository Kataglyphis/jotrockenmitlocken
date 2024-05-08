import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/about_me_page.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/about_me_page_navbar_config.dart';
import 'package:jotrockenmitlocken/Pages/Blog/blog_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BooksPage/books_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BooksPage/books_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/FilmsPage/films_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/FilmsPage/films_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/data_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/data_pages_navbar_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/media_critics_page.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/document_page_navbar_config.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/documents_page.dart';

import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_page.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/landing_page.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/landing_page_navbar_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/QuotesPage/quotes_page.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/QuotesPage/quotations_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/blog_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/my_two_cents_config.dart';
import 'package:jotrockenmitlockenrepo/Routing/router_creater.dart';

import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

class JotrockenMitLockenRoutes extends RoutesCreator {
  //final _footerKey = GlobalKey<NavigatorState>(debugLabel: "_footerKey");
  @override
  List<(Widget, StatefulBranchInfoProvider)> getAllPagesWithConfigs(
      AppAttributes appAttributes) {
    List<(Widget, StatefulBranchInfoProvider)> allPagesAndConfigs = [];
    allPagesAndConfigs += _getNavBarPagesAndConfigs(appAttributes);
    allPagesAndConfigs += _getFooterPagesAndConfigs(appAttributes);
    allPagesAndConfigs += _getBlogPagesAndConfigs(appAttributes);
    allPagesAndConfigs += _getDataPagesAndConfigs(appAttributes);
    allPagesAndConfigs += _getMediaCriticsPagesAndConfigs(appAttributes);

    return allPagesAndConfigs;
  }

  List<(Widget, StatefulBranchInfoProvider)> _getDataPagesAndConfigs(
      AppAttributes appAttributes) {
    return [
      (
        QuotesPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        QuotationsPageConfig()
      ),
      (
        BooksPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        BooksPageConfig()
      ),
      (
        FilmsPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        FilmsPageConfig()
      ),
    ];
  }

  List<(Widget, StatefulBranchInfoProvider)> _getNavBarPagesAndConfigs(
      AppAttributes appAttributes) {
    return [
      (
        LandingPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        LandingPageNavBarConfig()
      ),
      (
        AboutMePage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        AboutMePageNavBarConfig()
      ),
      (
        DataPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        DataPageNavBarConfig()
      ),
      (
        DocumentPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        DocumentPageNavBarConfig()
      ),
    ];
  }

  List<(Widget, StatefulBranchInfoProvider)> _getMediaCriticsPagesAndConfigs(
      AppAttributes appAttributes) {
    List<MyTwoCentsConfig> blogPagesConfigs =
        appAttributes.screenConfigurations.getMediaCriticsPagesConfig();
    List<(Widget, StatefulBranchInfoProvider)> footerPages = blogPagesConfigs
        .map(
          (pageConfig) => (
            MediaCriticsPage(
              footer: getFooter(appAttributes),
              appAttributes: appAttributes,
              mediaCriticsPageConfig: pageConfig,
            ),
            pageConfig
          ),
        )
        .toList();

    return footerPages;
  }

  List<(Widget, StatefulBranchInfoProvider)> _getBlogPagesAndConfigs(
      AppAttributes appAttributes) {
    List<BlogPageConfig> blogPagesConfigs =
        appAttributes.screenConfigurations.getBlogPagesConfig();
    List<(Widget, StatefulBranchInfoProvider)> footerPages = blogPagesConfigs
        .map(
          (pageConfig) => (
            BlogPage(
              footer: getFooter(appAttributes),
              appAttributes: appAttributes,
              blogPageConfig: pageConfig,
            ),
            pageConfig
          ),
        )
        .toList();

    return footerPages;
  }

  List<(Widget, StatefulBranchInfoProvider)> _getFooterPagesAndConfigs(
      AppAttributes appAttributes) {
    List<FooterPageConfig> footerPagesConfigs =
        appAttributes.screenConfigurations.getFooterPagesConfig();
    List<(Widget, StatefulBranchInfoProvider)> footerPages = footerPagesConfigs
        .map(
          (pageConfig) => (
            FooterPage(
              footer: getFooter(appAttributes),
              appAttributes: appAttributes,
              filePathDe: pageConfig.getFilePathDe(),
              filePathEn: pageConfig.getFilePathEn(),
            ),
            pageConfig
          ),
        )
        .toList();

    return footerPages;
  }

  @override
  Footer getFooter(AppAttributes appAttributes) {
    return Footer(
      footerPagesConfigs:
          appAttributes.screenConfigurations.getFooterPagesConfig(),
      userSettings: appAttributes.userSettings,
      footerConfig: appAttributes.footerConfig,
    );
  }
}
