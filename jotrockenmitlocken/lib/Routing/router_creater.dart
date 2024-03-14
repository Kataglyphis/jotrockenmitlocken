import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:jotrockenmitlockenrepo/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/navbar_pages_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_config.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

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

  static List<StatefulShellBranch> createStatefulShellBranches(
    AppFrameAttributes appFrameAttributes,
    List<StatefulBranchInfoProvider> configs,
  ) {
    List<StatefulShellBranch> branches = [];
    for (int i = 0; i < configs.length; i++) {
      final pageConfig = configs[i];
      branches.add(
        StatefulShellBranch(
          routes: <RouteBase>[
            buildGoRouteForSPA(
              pageConfig.getRoutingName(),
              pageConfig.getPagesFactory().createPage(appFrameAttributes),
            )
          ],
        ),
      );
    }
    return branches;
  }

  static List<StatefulShellBranch> getErrorPageRouting(
    AppFrameAttributes appFrameAttributes,
  ) {
    List<PagesConfig> errorPageConfig =
        ScreenConfigurations.getErrorPagesConfig();
    return createStatefulShellBranches(appFrameAttributes, errorPageConfig);
  }

  static List<StatefulShellBranch> createFooterBranches(
      AppFrameAttributes appFrameAttributes) {
    List<PagesConfig> footerPagesConfigs =
        ScreenConfigurations.getFooterPagesConfig();
    return createStatefulShellBranches(appFrameAttributes, footerPagesConfigs);
  }

  static List<StatefulShellBranch> createNavBarBranches(
    AppFrameAttributes appFrameAttributes,
  ) {
    List<NavBarPagesConfig> navRailPagesConfigs =
        ScreenConfigurations.getNavRailPagesConfig();
    return createStatefulShellBranches(appFrameAttributes, navRailPagesConfigs);
  }

  static List<StatefulShellBranch> createBlogBranches(
    AppFrameAttributes appFrameAttributes,
  ) {
    List<PagesConfig> blogPagesConfigs =
        ScreenConfigurations.getBlogPagesConfig();
    return createStatefulShellBranches(appFrameAttributes, blogPagesConfigs);
  }
}
