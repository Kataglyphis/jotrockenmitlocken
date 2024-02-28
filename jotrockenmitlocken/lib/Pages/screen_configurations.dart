import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/about_me_page.dart';
import 'package:jotrockenmitlocken/Pages/Blog/ai_blog_page.dart';
import 'package:jotrockenmitlocken/Pages/Blog/rendering_blog_page.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/documents_page.dart';
import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page.dart';
import 'package:jotrockenmitlocken/Pages/Footer/contact.dart';
import 'package:jotrockenmitlocken/Pages/Footer/cookie_declaration.dart';
import 'package:jotrockenmitlocken/Pages/Footer/declaration_on_accessibility.dart';
import 'package:jotrockenmitlocken/Pages/Footer/imprint.dart';
import 'package:jotrockenmitlocken/Pages/Footer/privacy_policy.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/landing_page.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quotes_page.dart';
import 'package:jotrockenmitlocken/Pages/navbar_pages_config.dart';
import 'package:jotrockenmitlocken/Pages/pages_config.dart';

class ScreenConfigurations {
  static List<String> getAllValidRoutes() {
    List<String> allValidRoutes = [];
    for (NavBarPagesConfig navRailPageConfig in getNavRailPagesConfig()) {
      allValidRoutes.add(navRailPageConfig.routingName);
    }
    for (PagesConfig navRailPageConfig in getFooterPagesConfig()) {
      allValidRoutes.add(navRailPageConfig.routingName);
    }
    for (PagesConfig navRailPageConfig in getErrorPagesConfig()) {
      allValidRoutes.add(navRailPageConfig.routingName);
    }
    for (PagesConfig blogPageConfig in getBlogPagesConfig()) {
      allValidRoutes.add(blogPageConfig.routingName);
    }
    return allValidRoutes;
  }

  static List<PagesConfig> getErrorPagesConfig() {
    return [PagesConfig(routingName: '/error', pagesCreator: ErrorPage())];
  }

  static List<NavBarPagesConfig> getNavRailPagesConfig() {
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

  static List<PagesConfig> getBlogPagesConfig() {
    return [
      PagesConfig(
        routingName: "/aiBlog",
        pagesCreator: AiBlogPage(),
      ),
      PagesConfig(
        routingName: "/renderingBlog",
        pagesCreator: RenderingBlogPage(),
      ),
    ];
  }

  static List<PagesConfig> getFooterPagesConfig() {
    return [
      PagesConfig(
        routingName: "/imprint",
        pagesCreator: ImprintPage(),
      ),
      PagesConfig(
        routingName: "/contact",
        pagesCreator: ContactPage(),
      ),
      PagesConfig(
        routingName: "/privacyPolicy",
        pagesCreator: PrivacyPolicyPage(),
      ),
      PagesConfig(
        routingName: "/cookieStatement",
        pagesCreator: CookieDeclarationPage(),
      ),
      PagesConfig(
        routingName: "/declarationOnAccessibility",
        pagesCreator: DeclarationOnAccessibilityPage(),
      ),
    ];
  }

  static List<NavigationDestination> getAppBarDestinations(
      BuildContext context) {
    var result = getNavRailPagesConfig()
        .map((config) => config.pagesCreator.getNavigationDestination(context))
        .toList();
    return result;
  }

  static List<NavigationRailDestination> getNavRailDestinations(
      BuildContext context) {
    var result = getAppBarDestinations(context)
        .map(
          (destination) => NavigationRailDestination(
            icon: Tooltip(
              message: destination.label,
              child: destination.icon,
            ),
            selectedIcon: Tooltip(
              message: destination.label,
              child: destination.selectedIcon,
            ),
            label: Text(destination.label),
          ),
        )
        .toList();
    return result;
  }
}
