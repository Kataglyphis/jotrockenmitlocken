import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Routing/screen_configurations.dart';
import 'package:go_router/go_router.dart';

class NavigationBars extends StatefulWidget {
  const NavigationBars({
    super.key,
    required this.navigationShell,
    required this.currentNavBarIndex,
    required this.handleChangedNavBarIndex,
    required this.screenConfigurations,
  });

  final int currentNavBarIndex;
  final StatefulNavigationShell navigationShell;
  final void Function(int value) handleChangedNavBarIndex;
  final ScreenConfigurations screenConfigurations;

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NavigationBars oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // App NavigationBar should get first focus.
    Widget navigationBar = Focus(
        autofocus: true,
        child: NavigationBar(
          selectedIndex: widget.currentNavBarIndex,
          onDestinationSelected: (index) {
            widget.handleChangedNavBarIndex(index);
            widget.navigationShell.goBranch(index);
          },
          destinations:
              widget.screenConfigurations.getAppBarDestinations(context),
        ));

    return navigationBar;
  }
}
