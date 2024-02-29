import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:jotrockenmitlocken/Pages/Home/Transitions/navigation_transition.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/expanded_trailing_actions.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/brightness_button.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/color_seed_button.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/language_button.dart';

import 'package:jotrockenmitlocken/Widgets/Navigation/navigation_bars.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';

class Home extends StatefulWidget {
  Home(
      {super.key,
      required this.useLightMode,
      required this.useOtherLanguageMode,
      required this.colorSelected,
      required this.handleBrightnessChange,
      required this.handleLanguageChange,
      required this.handleColorSelect,
      required this.showMediumSizeLayout,
      required this.showLargeSizeLayout,
      required this.controller,
      required this.railAnimation,
      required this.scaffoldKey,
      required this.navigationShell,
      required this.handleChangedPageIndex});

  final bool useLightMode;
  final bool useOtherLanguageMode;
  final bool showMediumSizeLayout;
  final bool showLargeSizeLayout;

  final ColorSeed colorSelected;

  late final AnimationController controller;
  late final CurvedAnimation railAnimation;

  late final GlobalKey<ScaffoldState> scaffoldKey;
  late final StatefulNavigationShell navigationShell;

  final void Function() handleLanguageChange;
  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function(int value) handleColorSelect;

  final void Function(int value) handleChangedPageIndex;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentNavBarIndex = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    widget.handleChangedPageIndex(widget.navigationShell.currentIndex);
  }

  PreferredSizeWidget _createAppBar() {
    return AppBar(
      title: const Text(appName),
      actions: !widget.showMediumSizeLayout && !widget.showLargeSizeLayout
          ? [
              LanguageButton(
                handleLanguageChange: widget.handleLanguageChange,
              ),
              BrightnessButton(
                handleBrightnessChange: widget.handleBrightnessChange,
              ),
              ColorSeedButton(
                handleColorSelect: widget.handleColorSelect,
                colorSelected: widget.colorSelected,
              ),
            ]
          : [Container()],
    );
  }

  Widget _trailingActions() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: LanguageButton(
              handleLanguageChange: widget.handleLanguageChange,
              showTooltipBelow: false,
            ),
          ),
          Flexible(
            child: BrightnessButton(
              handleBrightnessChange: widget.handleBrightnessChange,
              showTooltipBelow: false,
            ),
          ),
          Flexible(
            child: ColorSeedButton(
              handleColorSelect: widget.handleColorSelect,
              colorSelected: widget.colorSelected,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: ((Localizations.localeOf(context) == const Locale('de') &&
                    widget.useOtherLanguageMode) ||
                (Localizations.localeOf(context) == const Locale('en')))
            ? const Locale('en')
            : const Locale('de'),
        // Using a Builder to get the correct BuildContext.
        // Alternatively, you can create a new widget and Localizations.override
        // will pass the updated BuildContext to the new widget.
        child: SelectionArea(
          child: Builder(
            builder: (context) {
              return AnimatedBuilder(
                animation: widget.controller,
                builder: (context, child) {
                  return NavigationTransition(
                    navigationShell: widget.navigationShell,
                    showFooter: widget.showLargeSizeLayout ||
                        widget.showMediumSizeLayout,
                    scaffoldKey: widget.scaffoldKey,
                    animationController: widget.controller,
                    railAnimation: widget.railAnimation,
                    appBar: _createAppBar(),
                    body: Flexible(
                      child: widget.navigationShell,
                    ),
                    navigationRail: NavigationRail(
                      extended: widget.showLargeSizeLayout,
                      destinations:
                          ScreenConfigurations.getNavRailDestinations(context),
                      selectedIndex: (widget.navigationShell.currentIndex <
                              ScreenConfigurations.getAppBarDestinations(
                                      context)
                                  .length)
                          ? widget.navigationShell.currentIndex
                          : currentNavBarIndex,
                      onDestinationSelected: (index) {
                        currentNavBarIndex = index;
                        widget.navigationShell.goBranch(currentNavBarIndex);
                      },
                      trailing: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: widget.showLargeSizeLayout
                              ? ExpandedTrailingActions(
                                  useLightMode: widget.useLightMode,
                                  useOtherLanguageMode:
                                      widget.useOtherLanguageMode,
                                  handleLanguageChange:
                                      widget.handleLanguageChange,
                                  handleBrightnessChange:
                                      widget.handleBrightnessChange,
                                  handleColorSelect: widget.handleColorSelect,
                                  colorSelected: widget.colorSelected,
                                )
                              : _trailingActions(),
                        ),
                      ),
                    ),
                    navigationBar: NavigationBars(
                      currentNavBarIndex: (widget.navigationShell.currentIndex <
                              ScreenConfigurations.getAppBarDestinations(
                                      context)
                                  .length)
                          ? widget.navigationShell.currentIndex
                          : currentNavBarIndex,
                      navigationShell: widget.navigationShell,
                      handleChangedNavBarIndex: (index) {
                        currentNavBarIndex = index;
                        widget.navigationShell.goBranch(index);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
