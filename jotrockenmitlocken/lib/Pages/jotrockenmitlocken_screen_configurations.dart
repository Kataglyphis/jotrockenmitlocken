import 'package:jotrockenmitlocken/Pages/AboutMePage/about_me_page_navbar_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BlockOverviewPage/block_overview_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BooksPage/books_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/FilmsPage/films_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/GamesPage/games_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/data_pages_navbar_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/document_page_navbar_config.dart';
import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page_stateful_branch_info_provider.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/contact_footer_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/cookie_declaration_footer_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/copyright_footer_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/declaration_on_accessibility_footer_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/imprint_footer_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/privacy_policy_config.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/landing_page_navbar_page_config.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/QuotesPage/quotations_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/blog_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/my_two_cents_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';
import 'package:jotrockenmitlockenrepo/Routing/screen_configurations.dart';

class JotrockenmitLockenScreenConfigurations extends ScreenConfigurations {
  List<BlogPageConfig> blogPageConfigs;
  List<MyTwoCentsConfig> twoCentsConfigs;
  JotrockenmitLockenScreenConfigurations.fromBlogAndDataConfigs(
      {required this.blogPageConfigs, required this.twoCentsConfigs});

  @override
  bool disableFooter() {
    return false;
  }

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
  List<StatefulBranchInfoProvider> getDataPagesConfig() {
    return [
      QuotationsPageConfig(),
      BooksPageConfig(),
      FilmsPageConfig(),
      GamesPageConfig(),
      BlockOverviewPageConfig(),
    ];
  }

  @override
  List<StatefulBranchInfoProvider> getErrorPagesConfig() {
    return [ErrorPageStatefulBranchInfoProvider()];
  }

  @override
  List<NavBarPageConfig> getNavRailPagesConfig() {
    return [
      LandingPageNavBarConfig(),
      AboutMePageNavBarConfig(),
      DataPageNavBarConfig(),
      DocumentPageNavBarConfig(),
    ];
  }

  @override
  List<BlogPageConfig> getBlogPagesConfig() {
    return blogPageConfigs;
  }

  @override
  List<MyTwoCentsConfig> getMediaCriticsPagesConfig() {
    return twoCentsConfigs;
  }

  @override
  List<FooterPageConfig> getFooterPagesConfig() {
    return [
      ImprintFooterConfig(),
      ContactFooterConfig(),
      PrivacyPolicyFooterConfig(),
      CookieDeclarationFooterConfig(),
      DeclarationOnAccessibilityFooterConfig(),
      CopyRightFooterConfig()
    ];
  }
}
