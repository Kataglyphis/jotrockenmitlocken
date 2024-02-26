import 'package:flutter/material.dart';

import 'package:jotrockenmitlocken/Pages/Home/Transitions/bar_transition.dart';
import 'package:jotrockenmitlocken/Pages/Home/Transitions/rail_transition.dart';
import 'package:jotrockenmitlocken/Pages/Footer/footer.dart';

import 'package:go_router/go_router.dart';

class NavigationTransition extends StatefulWidget {
  const NavigationTransition(
      {super.key,
      required this.scaffoldKey,
      required this.animationController,
      required this.railAnimation,
      required this.navigationRail,
      required this.navigationBar,
      required this.appBar,
      required this.body,
      required this.showFooter,
      required this.navigationShell});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final AnimationController animationController;
  final CurvedAnimation railAnimation;
  final Widget navigationRail;
  final Widget navigationBar;
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool showFooter;
  final StatefulNavigationShell navigationShell;

  @override
  State<NavigationTransition> createState() => _NavigationTransitionState();
}

class _NavigationTransitionState extends State<NavigationTransition> {
  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
  late final ReverseAnimation barAnimation;
  bool controllerInitialized = false;
  bool showDivider = false;
  late int selectedIndex;

  @override
  void initState() {
    super.initState();

    controller = widget.animationController;
    railAnimation = widget.railAnimation;

    barAnimation = ReverseAnimation(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //key: widget.scaffoldKey,
      appBar: widget.appBar,
      body: Container(
        child: Row(
          children: <Widget>[
            RailTransition(
              animation: railAnimation,
              backgroundColor: colorScheme.surface,
              child: widget.navigationRail,
            ),
            widget.body,
          ],
        ),
      ),
      bottomNavigationBar: widget.showFooter
          ? const Footer()
          : BarTransition(
              animation: barAnimation,
              railAnimation: railAnimation,
              backgroundColor: colorScheme.surface,
              child: widget.navigationBar,
            ),
    );
  }
}
