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
    List<(Widget, StatefulBranchInfoProvider)> allPages =
        getAllPagesWithConfigs(appAttributes);
    return allPages[currentPageIndex].$2.getRoutingName();
  }

  List<(Widget, StatefulBranchInfoProvider)> getAllPagesWithConfigs(
      AppAttributes appAttributes);
  Footer getFooter(AppAttributes appAttributes);

  GoRouter getRouterConfig(
      AppAttributes appAttributes, AnimationController controller) {
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
            return Home(
                handleChangedPageIndex: (index) {
                  currentPageIndex = index;
                },
                scaffoldKey: scaffoldKey,
                footer: getFooter(appAttributes),
                appAttributes: appAttributes,
                controller: controller,
                navigationShell: navigationShell);
          },
          branches: createBranches(appAttributes),
        )
      ],
      redirect: (BuildContext context, GoRouterState state) {
        var allValidRoutes =
            appAttributes.screenConfigurations.getAllValidRoutes();
        if (!allValidRoutes.contains(state.fullPath)) {
          return appAttributes.screenConfigurations
              .getErrorPagesConfig()
              .first
              .getRoutingName();
        }
        // no need to redirect at all
        return null;
      },
    );
  }

  GoRoute buildGoRouteForSPA(
      (Widget, StatefulBranchInfoProvider) allPagesWithConfigs,
      AppAttributes appAttributes) {
    return GoRoute(
        path: allPagesWithConfigs.$2.getRoutingName(),
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: allPagesWithConfigs.$1,
          );
        });
  }

  List<StatefulShellBranch> createStatefulShellBranches(
    AppAttributes appAttributes,
    List<(Widget, StatefulBranchInfoProvider)> allPagesWithConfigs,
  ) {
    List<StatefulShellBranch> branches = [];
    for (int i = 0; i < allPagesWithConfigs.length; i++) {
      final pageWithConfig = allPagesWithConfigs[i];

      branches.add(
        StatefulShellBranch(
          routes: <RouteBase>[
            buildGoRouteForSPA(
              pageWithConfig,
              appAttributes,
            )
          ],
        ),
      );
    }
    return branches;
  }

  createBranches(AppAttributes appAttributes) {
    List<(Widget, StatefulBranchInfoProvider)> allPagesWithConfigs =
        getAllPagesWithConfigs(appAttributes);
    return createStatefulShellBranches(appAttributes, allPagesWithConfigs);
  }
}
