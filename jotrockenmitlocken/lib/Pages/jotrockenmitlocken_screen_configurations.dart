import 'package:jotrockenmitlocken/Pages/AboutMePage/about_me_page.dart';
import 'package:jotrockenmitlocken/Pages/Blog/ai_blog_page.dart';
import 'package:jotrockenmitlocken/Pages/Blog/rendering_blog_page.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/documents_page.dart';
import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/contact_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/cookie_declaration_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/declaration_on_accessibility_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/imprint_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/privacy_policy_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/contact.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/cookie_declaration.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/declaration_on_accessibility.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/imprint.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/privacy_policy.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/ai_playground.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/landing_page.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/rendering_playground.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quotes_page.dart';
import 'package:jotrockenmitlocken/Pages/blog_pages_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_pages_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_pages_creator.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';
import 'package:jotrockenmitlockenrepo/Routing/screen_configurations.dart';

class JotrockenmitLockenScreenConfigurations extends ScreenConfigurations {
  @override
  bool disableFooter() {
    return false;
  }

  @override
  List<StatefulBranchInfoProvider> getAllPagesConfigs() {
    List<StatefulBranchInfoProvider> pagesConfigs = [];
    for (NavBarPagesConfig navRailPageConfig in getNavRailPagesConfig()) {
      pagesConfigs.add(navRailPageConfig);
    }
    for (PagesConfig navRailPageConfig in getFooterPagesConfig()) {
      pagesConfigs.add(navRailPageConfig);
    }
    for (PagesConfig blogPageConfig in getBlogPagesConfig()) {
      pagesConfigs.add(blogPageConfig);
    }
    for (PagesConfig navRailPageConfig in getErrorPagesConfig()) {
      pagesConfigs.add(navRailPageConfig);
    }
    return pagesConfigs;
  }

  @override
  List<PagesConfig> getErrorPagesConfig() {
    return [PagesConfig(routingName: '/error', pagesCreator: ErrorPage())];
  }

  @override
  List<NavBarPagesConfig> getNavRailPagesConfig() {
    return [
      NavBarPagesConfig(
        routingName: "/home",
        pagesCreator: LandingPage(),
      ),
      NavBarPagesConfig(
        routingName: "/aboutMe",
        pagesCreator: AboutMePage(),
      ),
      NavBarPagesConfig(
        routingName: "/quotations",
        pagesCreator: QuotesPage(),
      ),
      NavBarPagesConfig(
        routingName: "/documents",
        pagesCreator: DocumentPage(),
      ),
    ];
  }

  static List<BlogPagesConfig> getBlogPagesConfig() {
    return [
      BlogPagesConfig(
          routingName: "/aiBlog",
          pagesCreator: AiBlogPage(),
          landingPageEntry: const AIPlayground(),
          landingPageAlignment: LandingPageAlignment.left),
      BlogPagesConfig(
          routingName: "/renderingBlog",
          pagesCreator: RenderingBlogPage(),
          landingPageEntry: const RenderingPlayground(),
          landingPageAlignment: LandingPageAlignment.right),
    ];
  }

  static List<FooterPagesConfig> getFooterPagesConfig() {
    return [
      ImprintPagesConfig(
        routingName: "/imprint",
        pagesCreator: ImprintPage(),
      ),
      ContactPagesConfig(
        routingName: "/contact",
        pagesCreator: ContactPage(),
      ),
      PrivacyPolicyPagesConfig(
        routingName: "/privacyPolicy",
        pagesCreator: PrivacyPolicyPage(),
      ),
      CookieDeclarationPagesConfig(
        routingName: "/cookieStatement",
        pagesCreator: CookieDeclarationPage(),
      ),
      DeclarationOnAccessibilityPagesConfig(
        routingName: "/declarationOnAccessibility",
        pagesCreator: DeclarationOnAccessibilityPage(),
      ),
    ];
  }
}
