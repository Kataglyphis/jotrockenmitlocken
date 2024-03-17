import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:jotrockenmitlocken/Pages/Home/Transitions/navigation_transition.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/expanded_trailing_actions.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/brightness_button.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/color_seed_button.dart';
import 'package:jotrockenmitlocken/Pages/Home/Widgets/language_button.dart';

import 'package:jotrockenmitlockenrepo/Routing/navigation_bars.dart';
import 'package:jotrockenmitlockenrepo/Pages/app_attributes.dart';
import 'package:jotrockenmitlocken/constant_app_setting.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Routing/screen_configurations.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key,
      required this.appAttributes,
      required this.controller,
      required this.scaffoldKey,
      required this.navigationShell,
      required this.handleChangedPageIndex});

  final AppAttributes appAttributes;

  final AnimationController controller;

  final GlobalKey<ScaffoldState> scaffoldKey;
  final StatefulNavigationShell navigationShell;

  final void Function(int value) handleChangedPageIndex;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentNavBarIndex = 0;
  ScreenConfigurations screenConfigurations =
      JotrockenmitLockenScreenConfigurations();

  @override
  void didUpdateWidget(Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.handleChangedPageIndex(widget.navigationShell.currentIndex);
  }

  PreferredSizeWidget _createAppBar() {
    return AppBar(
      title: const Text(appName),
      actions: !widget.appAttributes.showMediumSizeLayout &&
              !widget.appAttributes.showLargeSizeLayout
          ? [
              LanguageButton(
                handleLanguageChange: widget.appAttributes.handleLanguageChange,
              ),
              BrightnessButton(
                handleBrightnessChange:
                    widget.appAttributes.handleBrightnessChange,
              ),
              ColorSeedButton(
                handleColorSelect: widget.appAttributes.handleColorSelect,
                colorSelected: widget.appAttributes.colorSelected,
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
              handleLanguageChange: widget.appAttributes.handleLanguageChange,
              showTooltipBelow: false,
            ),
          ),
          Flexible(
            child: BrightnessButton(
              handleBrightnessChange:
                  widget.appAttributes.handleBrightnessChange,
              showTooltipBelow: false,
            ),
          ),
          Flexible(
            child: ColorSeedButton(
              handleColorSelect: widget.appAttributes.handleColorSelect,
              colorSelected: widget.appAttributes.colorSelected,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: ((Localizations.localeOf(context) == const Locale('de') &&
                    widget.appAttributes.useOtherLanguageMode) ||
                (Localizations.localeOf(context) == const Locale('en')))
            ? const Locale('en')
            : const Locale('de'),
        child: SelectionArea(
          child: Builder(
            builder: (context) {
              return AnimatedBuilder(
                animation: widget.controller,
                builder: (context, child) {
                  return NavigationTransition(
                    navigationShell: widget.navigationShell,
                    showFooter: widget.appAttributes.showLargeSizeLayout ||
                        widget.appAttributes.showMediumSizeLayout,
                    scaffoldKey: widget.scaffoldKey,
                    animationController: widget.controller,
                    railAnimation: widget.appAttributes.railAnimation,
                    appBar: _createAppBar(),
                    body: Flexible(
                      child: widget.navigationShell,
                    ),
                    navigationRail: NavigationRail(
                      extended: widget.appAttributes.showLargeSizeLayout,
                      destinations:
                          screenConfigurations.getNavRailDestinations(context),
                      selectedIndex: (widget.navigationShell.currentIndex <
                              screenConfigurations
                                  .getAppBarDestinations(context)
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
                          child: widget.appAttributes.showLargeSizeLayout
                              ? ExpandedTrailingActions(
                                  appAttributes: widget.appAttributes,
                                )
                              : _trailingActions(),
                        ),
                      ),
                    ),
                    navigationBar: NavigationBars(
                      screenConfigurations: screenConfigurations,
                      currentNavBarIndex: (widget.navigationShell.currentIndex <
                              screenConfigurations
                                  .getAppBarDestinations(context)
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
