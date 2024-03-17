import 'package:flutter/material.dart';

abstract class ScreenConfigurations {
  List<NavigationDestination> getAppBarDestinations(BuildContext context);
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
}
