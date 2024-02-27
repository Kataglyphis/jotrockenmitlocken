import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/navbar_pages_config.dart';
import 'package:jotrockenmitlocken/Pages/pages_config.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';

class RoutesCreator {
  static GoRoute buildGoRouteForSPA(String path, Widget child) {
    return GoRoute(
        path: path,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: child,
          );
        });
  }

  static List<StatefulShellBranch> createFooterBranches(
      AppFrameAttributes appFrameAttributes,
      bool showMediumSizeLayout,
      bool showLargeSizeLayout) {
    List<PagesConfig> footerPagesConfigs =
        ScreenConfigurations.getFooterPagesConfig();
    List<StatefulShellBranch> footerBranches = [];
    for (int i = 0; i < footerPagesConfigs.length; i++) {
      final pageConfig = footerPagesConfigs[i];
      footerBranches.add(
        StatefulShellBranch(
          routes: <RouteBase>[
            buildGoRouteForSPA(
              pageConfig.routingName,
              pageConfig.pagesCreator.createPage(appFrameAttributes),
            )
          ],
        ),
      );
    }
    return footerBranches;
  }

  static List<StatefulShellBranch> createNavBarBranches(
    AppFrameAttributes appFrameAttributes,
    //GlobalKey<NavigatorState> sectionNavigatorKey,
  ) {
    List<NavBarPagesConfig> navRailPagesConfigs =
        ScreenConfigurations.getNavRailPagesConfig();
    List<StatefulShellBranch> navBarBranches = [];
    for (int i = 0; i < navRailPagesConfigs.length; i++) {
      final pageConfig = navRailPagesConfigs[i];
      navBarBranches.add(
        StatefulShellBranch(
          //navigatorKey: (i == 0) ? sectionNavigatorKey : null,
          routes: <RouteBase>[
            buildGoRouteForSPA(
              pageConfig.routingName,
              pageConfig.pagesCreator.createPage(appFrameAttributes),
            )
          ],
        ),
      );
    }
    return navBarBranches;
  }
}
