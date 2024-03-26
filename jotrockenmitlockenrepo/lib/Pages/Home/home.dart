import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';

import 'package:jotrockenmitlockenrepo/Pages/Home/Transitions/navigation_transition.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/expanded_trailing_actions.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/brightness_button.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/color_seed_button.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/language_button.dart';
import 'package:jotrockenmitlockenrepo/Pages/Home/Widgets/trailing_actions.dart';

import 'package:jotrockenmitlockenrepo/Routing/navigation_bars.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key,
      required this.footer,
      required this.appAttributes,
      required this.controller,
      required this.scaffoldKey,
      required this.navigationShell,
      required this.handleChangedPageIndex});

  final AppAttributes appAttributes;
  final Footer footer;
  final AnimationController controller;

  final GlobalKey<ScaffoldState> scaffoldKey;
  final StatefulNavigationShell navigationShell;

  final void Function(int value) handleChangedPageIndex;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentNavBarIndex = 0;

  @override
  void didUpdateWidget(Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.handleChangedPageIndex(widget.navigationShell.currentIndex);
  }

  PreferredSizeWidget _createAppBar() {
    var buttonNames = widget.appAttributes.homeConfig.getButtonNames(context);
    return AppBar(
      title: Text(widget.appAttributes.appName),
      actions: !widget.appAttributes.showMediumSizeLayout &&
              !widget.appAttributes.showLargeSizeLayout
          ? [
              if (buttonNames.language != null &&
                  widget.appAttributes.handleLanguageChange != null)
                LanguageButton(
                  handleLanguageChange:
                      widget.appAttributes.handleLanguageChange!,
                  title: buttonNames.language!,
                ),
              if (buttonNames.brightness != null &&
                  widget.appAttributes.handleBrightnessChange != null)
                BrightnessButton(
                  handleBrightnessChange:
                      widget.appAttributes.handleBrightnessChange!,
                  message: buttonNames.brightness!,
                ),
              if (buttonNames.color != null &&
                  widget.appAttributes.handleColorSelect != null)
                ColorSeedButton(
                  handleColorSelect: widget.appAttributes.handleColorSelect!,
                  colorSelected: widget.appAttributes.colorSelected,
                  title: buttonNames.color!,
                ),
            ]
          : [Container()],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> supportedLang = widget.appAttributes.supportedLanguages;
    assert(supportedLang.length <= 2 && supportedLang.isNotEmpty,
        "For now only max. 2 different lang are supported. And you need at least 1 :)");
    Locale currentLocale = supportedLang[0];
    if (widget.appAttributes.useOtherLanguageMode != null) {
      if (supportedLang.length == 2 &&
              (Localizations.localeOf(context) == supportedLang[0] &&
                  widget.appAttributes.useOtherLanguageMode!) ||
          (Localizations.localeOf(context) == supportedLang[1])) {
        currentLocale = supportedLang[1];
      }
    }
    return Localizations.override(
        context: context,
        locale: currentLocale,
        child: SelectionArea(
          child: Builder(
            builder: (context) {
              return AnimatedBuilder(
                animation: widget.controller,
                builder: (context, child) {
                  return NavigationTransition(
                    footer: widget.footer,
                    showFooter: (widget.appAttributes.showLargeSizeLayout ||
                            widget.appAttributes.showMediumSizeLayout) &&
                        !widget.appAttributes.screenConfigurations
                            .disableFooter(),
                    scaffoldKey: widget.scaffoldKey,
                    animationController: widget.controller,
                    railAnimation: widget.appAttributes.railAnimation,
                    appBar: _createAppBar(),
                    body: Expanded(
                      child: widget.navigationShell,
                    ),
                    navigationRail: NavigationRail(
                      extended: widget.appAttributes.showLargeSizeLayout,
                      destinations: widget.appAttributes.screenConfigurations
                          .getNavRailDestinations(context),
                      selectedIndex: (widget.navigationShell.currentIndex <
                              widget.appAttributes.screenConfigurations
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
                                  buttonNames: widget.appAttributes.homeConfig
                                      .getButtonNames(context),
                                  appAttributes: widget.appAttributes,
                                )
                              : TrailingActions(
                                  appAttributes: widget.appAttributes,
                                ),
                        ),
                      ),
                    ),
                    navigationBar: NavigationBars(
                      screenConfigurations:
                          widget.appAttributes.screenConfigurations,
                      currentNavBarIndex: (widget.navigationShell.currentIndex <
                              widget.appAttributes.screenConfigurations
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
