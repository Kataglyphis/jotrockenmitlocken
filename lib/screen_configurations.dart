import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/about_me_page.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/documents_page.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/landing_page.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quotes_page.dart';
import 'package:jotrockenmitlocken/Pages/navbar_pages_config.dart';
import 'constants.dart';

class ScreenConfigurations {
  static List<NavBarPagesConfig> getNavRailPagesConfig() {
    var aboutMe = "aboutMe";
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

  static List<NavigationDestination> getAppBarDestinations(
      BuildContext context) {
    var result = getNavRailPagesConfig()
        .map((config) => config.pagesCreator.getNavigationDestination(context))
        .toList();
    assert(result.length == ScreenSelected.values.length,
        'You must provide for each screen exact one app bar navigation!');
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
    assert(result.length == ScreenSelected.values.length,
        'You must provide for each screen exact one app bar navigation!');
    return result;
  }
}
