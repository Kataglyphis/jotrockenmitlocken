import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_page_config.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';

class GenericNavBarPageConfig extends NavBarPageConfig {
  final IconData icon;
  final IconData selectedIcon;
  final String Function(AppLocalizations) labelSelector;
  final String routingName;

  GenericNavBarPageConfig({
    required this.icon,
    required this.selectedIcon,
    required this.labelSelector,
    required this.routingName,
  });

  @override
  NavigationDestination getNavigationDestination(BuildContext context) {
    return NavigationDestination(
      tooltip: '',
      icon: Icon(icon),
      label: labelSelector(AppLocalizations.of(context)!),
      selectedIcon: Icon(selectedIcon),
    );
  }

  @override
  String getRoutingName() {
    return routingName;
  }
}
