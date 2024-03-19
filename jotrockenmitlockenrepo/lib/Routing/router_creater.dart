import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/home.dart';

import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

abstract class RoutesCreator {
  int currentPageIndex = 0;

  final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "_rootNavigatorKey");

  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffoldKey");

  String _getInitialLocation(AppAttributes appAttributes) {
    return appAttributes.screenConfigurations
        .getAllValidRoutes()[currentPageIndex];
  }

  Home getHome(
    Footer footer,
    AppAttributes appAttributes,
    AnimationController controller,
    StatefulNavigationShell navigationShell,
  );

  GoRouter getRouterConfig(AppAttributes appAttributes,
      AnimationController controller, Footer footer) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: _getInitialLocation(appAttributes),
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            // Return the widget that implements the custom shell (in this case
            // using a BottomNavigationBar). The StatefulNavigationShell is passed
            // to be able access the state of the shell and to navigate to other
            // branches in a stateful way.
            return getHome(footer, appAttributes, controller, navigationShell);
          },
          branches: RoutesCreator.createBranches(appAttributes),
        )
      ],
      redirect: (BuildContext context, GoRouterState state) {
        var allValidRoutes =
            appAttributes.screenConfigurations.getAllValidRoutes();
        if (!allValidRoutes.contains(state.fullPath)) {
          return appAttributes.screenConfigurations
              .getErrorPagesConfig()
              .first
              .routingName;
        }
        // no need to redirect at all
        return null;
      },
    );
  }

  static GoRoute buildGoRouteForSPA(
      StatefulBranchInfoProvider pageConfig, AppAttributes appAttributes) {
    return GoRoute(
        path: pageConfig.getRoutingName(),
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child:
                pageConfig.getPagesFactory().createPage(appAttributes, context),
          );
        });
  }

  static List<StatefulShellBranch> createStatefulShellBranches(
    AppAttributes appAttributes,
    List<StatefulBranchInfoProvider> configs,
  ) {
    List<StatefulShellBranch> branches = [];
    for (int i = 0; i < configs.length; i++) {
      final pageConfig = configs[i];

      branches.add(
        StatefulShellBranch(
          routes: <RouteBase>[
            buildGoRouteForSPA(
              pageConfig,
              appAttributes,
            )
          ],
        ),
      );
    }
    return branches;
  }

  static createBranches(AppAttributes appAttributes) {
    List<StatefulBranchInfoProvider> allPagesConfigs =
        appAttributes.screenConfigurations.getAllPagesConfigs();
    return createStatefulShellBranches(appAttributes, allPagesConfigs);
  }
}
