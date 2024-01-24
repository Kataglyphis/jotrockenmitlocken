import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'constants.dart';

class ScreenConfigurations {
  static List<NavigationDestination> getAppBarDestinations(
      BuildContext context) {
    var result = [
      NavigationDestination(
        tooltip: '',
        icon: const Icon(Icons.house_outlined),
        label: AppLocalizations.of(context)!.homepage,
        selectedIcon: const Icon(Icons.house),
      ),
      NavigationDestination(
        tooltip: '',
        icon: const Icon(Icons.person_outlined),
        label: AppLocalizations.of(context)!.aboutme,
        selectedIcon: const Icon(Icons.person),
      ),
      NavigationDestination(
        tooltip: '',
        icon: const Icon(Icons.record_voice_over_outlined),
        label: AppLocalizations.of(context)!.quotations,
        selectedIcon: const Icon(Icons.record_voice_over),
      ),
      NavigationDestination(
        tooltip: '',
        icon: const Icon(Icons.description_outlined),
        label: AppLocalizations.of(context)!.documents,
        selectedIcon: const Icon(Icons.description),
      )
    ];
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
