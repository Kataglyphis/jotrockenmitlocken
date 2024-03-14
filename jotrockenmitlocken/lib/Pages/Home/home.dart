import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:jotrockenmitlocken/Pages/Home/Transitions/navigation_transition.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/expanded_trailing_actions.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/brightness_button.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/color_seed_button.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/language_button.dart';

import 'package:jotrockenmitlocken/Widgets/Navigation/navigation_bars.dart';
import 'package:jotrockenmitlockenrepo/Pages/app_attributes.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key,
      required this.appFrameAttributes,
      required this.controller,
      required this.scaffoldKey,
      required this.navigationShell,
      required this.handleChangedPageIndex});

  final AppAttributes appFrameAttributes;

  final AnimationController controller;

  final GlobalKey<ScaffoldState> scaffoldKey;
  final StatefulNavigationShell navigationShell;

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
  void didUpdateWidget(Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.handleChangedPageIndex(widget.navigationShell.currentIndex);
  }

  PreferredSizeWidget _createAppBar() {
    return AppBar(
      title: const Text(appName),
      actions: !widget.appFrameAttributes.showMediumSizeLayout &&
              !widget.appFrameAttributes.showLargeSizeLayout
          ? [
              LanguageButton(
                handleLanguageChange:
                    widget.appFrameAttributes.handleLanguageChange,
              ),
              BrightnessButton(
                handleBrightnessChange:
                    widget.appFrameAttributes.handleBrightnessChange,
              ),
              ColorSeedButton(
                handleColorSelect: widget.appFrameAttributes.handleColorSelect,
                colorSelected: widget.appFrameAttributes.colorSelected,
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
              handleLanguageChange:
                  widget.appFrameAttributes.handleLanguageChange,
              showTooltipBelow: false,
            ),
          ),
          Flexible(
            child: BrightnessButton(
              handleBrightnessChange:
                  widget.appFrameAttributes.handleBrightnessChange,
              showTooltipBelow: false,
            ),
          ),
          Flexible(
            child: ColorSeedButton(
              handleColorSelect: widget.appFrameAttributes.handleColorSelect,
              colorSelected: widget.appFrameAttributes.colorSelected,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: ((Localizations.localeOf(context) == const Locale('de') &&
                    widget.appFrameAttributes.useOtherLanguageMode) ||
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
                    showFooter: widget.appFrameAttributes.showLargeSizeLayout ||
                        widget.appFrameAttributes.showMediumSizeLayout,
                    scaffoldKey: widget.scaffoldKey,
                    animationController: widget.controller,
                    railAnimation: widget.appFrameAttributes.railAnimation,
                    appBar: _createAppBar(),
                    body: Flexible(
                      child: widget.navigationShell,
                    ),
                    navigationRail: NavigationRail(
                      extended: widget.appFrameAttributes.showLargeSizeLayout,
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
                          child: widget.appFrameAttributes.showLargeSizeLayout
                              ? ExpandedTrailingActions(
                                  useLightMode:
                                      widget.appFrameAttributes.useLightMode,
                                  useOtherLanguageMode: widget
                                      .appFrameAttributes.useOtherLanguageMode,
                                  handleLanguageChange: widget
                                      .appFrameAttributes.handleLanguageChange,
                                  handleBrightnessChange: widget
                                      .appFrameAttributes
                                      .handleBrightnessChange,
                                  handleColorSelect: widget
                                      .appFrameAttributes.handleColorSelect,
                                  colorSelected:
                                      widget.appFrameAttributes.colorSelected,
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
