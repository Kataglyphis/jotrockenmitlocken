import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_pages_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

abstract class ScreenConfigurations {
  List<PagesConfig> getErrorPagesConfig();
  List<StatefulBranchInfoProvider> getAllPagesConfigs();
  List<NavBarPagesConfig> getNavRailPagesConfig();

  bool disableFooter();

  List<NavigationDestination> getAppBarDestinations(BuildContext context) {
    var result = getNavRailPagesConfig()
        .map((config) => config.pagesCreator.getNavigationDestination(context))
        .toList();
    return result;
  }

  List<NavigationRailDestination> getNavRailDestinations(BuildContext context) {
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

  List<String> getAllValidRoutes() {
    List<String> allValidRoutes = [];
    for (StatefulBranchInfoProvider pageConfig in getAllPagesConfigs()) {
      allValidRoutes.add(pageConfig.getRoutingName());
    }
    return allValidRoutes;
  }
}
