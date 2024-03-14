import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlocken/Pages/Home/home.dart';

import 'package:jotrockenmitlockenrepo/Pages/app_attributes.dart';
import 'package:jotrockenmitlocken/Pages/navbar_pages_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_config.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

class RoutesCreator {
  static int currentPageIndex = 0;
  static List<String> allValidRoutes = ScreenConfigurations.getAllValidRoutes();
  static final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "_rootNavigatorKey");

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffoldKey");

  static String _getInitialLocation() {
    return allValidRoutes[currentPageIndex];
  }

  static GoRouter getRouterConfig(
      AppAttributes appAttributes, AnimationController controller) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: _getInitialLocation(),
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            // Return the widget that implements the custom shell (in this case
            // using a BottomNavigationBar). The StatefulNavigationShell is passed
            // to be able access the state of the shell and to navigate to other
            // branches in a stateful way.
            return Home(
              appAttributes: appAttributes,
              controller: controller,
              scaffoldKey: scaffoldKey,
              navigationShell: navigationShell,
              handleChangedPageIndex: (index) {
                currentPageIndex = index;
              },
            );
          },
          branches: RoutesCreator.createNavBarBranches(
                appAttributes,
              ) +
              RoutesCreator.createFooterBranches(
                appAttributes,
              ) +
              RoutesCreator.createBlogBranches(
                appAttributes,
              ) +
              RoutesCreator.getErrorPageRouting(
                appAttributes,
              ),
        )
      ],
      redirect: (BuildContext context, GoRouterState state) {
        if (!allValidRoutes.contains(state.fullPath)) {
          return ScreenConfigurations.getErrorPagesConfig().first.routingName;
        }
        // no need to redirect at all
        return null;
      },
    );
  }

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
    AppAttributes appFrameAttributes,
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
    AppAttributes appFrameAttributes,
  ) {
    List<PagesConfig> errorPageConfig =
        ScreenConfigurations.getErrorPagesConfig();
    return createStatefulShellBranches(appFrameAttributes, errorPageConfig);
  }

  static List<StatefulShellBranch> createFooterBranches(
      AppAttributes appFrameAttributes) {
    List<PagesConfig> footerPagesConfigs =
        ScreenConfigurations.getFooterPagesConfig();
    return createStatefulShellBranches(appFrameAttributes, footerPagesConfigs);
  }

  static List<StatefulShellBranch> createNavBarBranches(
    AppAttributes appFrameAttributes,
  ) {
    List<NavBarPagesConfig> navRailPagesConfigs =
        ScreenConfigurations.getNavRailPagesConfig();
    return createStatefulShellBranches(appFrameAttributes, navRailPagesConfigs);
  }

  static List<StatefulShellBranch> createBlogBranches(
    AppAttributes appFrameAttributes,
  ) {
    List<PagesConfig> blogPagesConfigs =
        ScreenConfigurations.getBlogPagesConfig();
    return createStatefulShellBranches(appFrameAttributes, blogPagesConfigs);
  }
}
