import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlocken/AboutMe/about_me_table.dart';
import 'package:jotrockenmitlocken/AboutMe/perfect_day_chart.dart';
import 'package:jotrockenmitlocken/AboutMe/skill_table.dart';
import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/DocumentPage/document_table.dart';
import 'package:jotrockenmitlocken/Media/markdown_page.dart';
import 'package:jotrockenmitlocken/Media/quotes_list.dart';
import 'package:jotrockenmitlocken/browser_helper.dart';
import 'package:jotrockenmitlocken/footer.dart';
import 'package:jotrockenmitlocken/navigation_state.dart';
import 'package:jotrockenmitlocken/vertical_scroll_page.dart';
import 'Blog/blog.dart';
import 'constants.dart';
import 'package:jotrockenmitlocken/screen_configurations.dart';

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.

class AIPlayground extends StatefulWidget {
  const AIPlayground({
    super.key,
    required this.colorSelected,
  });
  final ColorSeed colorSelected;

  @override
  State<AIPlayground> createState() => _AIPlaygroundState();
}

class _AIPlaygroundState extends State<AIPlayground> {
  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(
        label: AppLocalizations.of(context)!.aiPlayground,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 50,
                icon: const FaIcon(FontAwesomeIcons.github),
                // color: Colors.black,
                onPressed: () {
                  final Uri toLaunch = Uri(
                      scheme: 'https',
                      host: 'github.com',
                      path: 'Kataglyphis/MachineLearningAlgorithms');
                  BrowserHelper.launchInBrowser(toLaunch);
                },
              ),
              Text(AppLocalizations.of(context)!.aiPlaygroundDescription)
            ],
          ),
          colDivider,
          applyBoxDecoration(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset("assets/images/funny_programmer.gif"),
              ),
              const EdgeInsets.all(0),
              0,
              0,
              5,
              widget.colorSelected.color),
          colDivider
        ]);
  }
}

class RenderingPlayground extends StatefulWidget {
  const RenderingPlayground({
    super.key,
    required this.colorSelected,
  });
  final ColorSeed colorSelected;

  @override
  State<RenderingPlayground> createState() => _RenderingPlaygroundState();
}

class _RenderingPlaygroundState extends State<RenderingPlayground> {
  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(
        label: AppLocalizations.of(context)!.renderingPlayground,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 50,
                icon: const FaIcon(FontAwesomeIcons.github),
                // color: Colors.black,
                onPressed: () {
                  final Uri toLaunch = Uri(
                      scheme: 'https',
                      host: 'github.com',
                      path: 'Kataglyphis/GraphicsEngineVulkan');
                  BrowserHelper.launchInBrowser(toLaunch);
                },
              ),
              Text(
                  AppLocalizations.of(context)!.renderingPlaygroundDescription),
            ],
          ),
          colDivider,
          applyBoxDecoration(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset("assets/images/cat-computer.gif"),
              ),
              const EdgeInsets.all(0),
              0,
              0,
              5,
              widget.colorSelected.color),
          colDivider
        ]);
  }
}

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
      required this.navigationShell});

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

  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: const Text(appName),
      actions: !widget.showMediumSizeLayout && !widget.showLargeSizeLayout
          ? [
              _LanguageButton(
                handleLanguageChange: widget.handleLanguageChange,
              ),
              _BrightnessButton(
                handleBrightnessChange: widget.handleBrightnessChange,
              ),
              _ColorSeedButton(
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
            child: _LanguageButton(
              handleLanguageChange: widget.handleLanguageChange,
              showTooltipBelow: false,
            ),
          ),
          Flexible(
            child: _BrightnessButton(
              handleBrightnessChange: widget.handleBrightnessChange,
              showTooltipBelow: false,
            ),
          ),
          Flexible(
            child: _ColorSeedButton(
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
        child: Builder(
          builder: (context) {
            return AnimatedBuilder(
              animation: widget.controller,
              builder: (context, child) {
                return NavigationTransition(
                  navigationShell: widget.navigationShell,
                  showFooter:
                      widget.showLargeSizeLayout || widget.showMediumSizeLayout,
                  scaffoldKey: widget.scaffoldKey,
                  animationController: widget.controller,
                  railAnimation: widget.railAnimation,
                  appBar: createAppBar(),
                  body: Flexible(
                    child: widget.navigationShell,
                  ),
                  navigationRail: NavigationRail(
                    extended: widget.showLargeSizeLayout,
                    destinations:
                        ScreenConfigurations.getNavRailDestinations(context),
                    selectedIndex: (widget.navigationShell.currentIndex <
                            ScreenConfigurations.getAppBarDestinations(context)
                                .length)
                        ? widget.navigationShell.currentIndex
                        : currentNavBarIndex,
                    onDestinationSelected: (index) {
                      currentNavBarIndex = index;
                      widget.navigationShell.goBranch(index);
                    },
                    trailing: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: widget.showLargeSizeLayout
                            ? _ExpandedTrailingActions(
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
                    currentNavBarIndex: currentNavBarIndex,
                    navigationShell: widget.navigationShell,
                    handleChangedNavBarIndex: (index) {
                      currentNavBarIndex = index;
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.handleLanguageChange,
    this.showTooltipBelow = true,
  });

  final Function handleLanguageChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: AppLocalizations.of(context)!.toogleLanguage,
      child: IconButton(
        icon: const Icon(Icons.translate),
        onPressed: () => handleLanguageChange(),
      ),
    );
  }
}

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange,
    this.showTooltipBelow = true,
  });

  final Function handleBrightnessChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: AppLocalizations.of(context)!.toogleBrightness,
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () => handleBrightnessChange(!isBright),
      ),
    );
  }
}

class _ColorSeedButton extends StatelessWidget {
  const _ColorSeedButton({
    required this.handleColorSelect,
    required this.colorSelected,
  });

  final void Function(int) handleColorSelect;
  final ColorSeed colorSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.palette_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: AppLocalizations.of(context)!.selectSeedColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorSeed.values.length, (index) {
          ColorSeed currentColor = ColorSeed.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentColor != colorSelected,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    currentColor == colorSelected
                        ? Icons.color_lens
                        : Icons.color_lens_outlined,
                    color: currentColor.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentColor.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: handleColorSelect,
    );
  }
}

class _ExpandedTrailingActions extends StatelessWidget {
  const _ExpandedTrailingActions({
    required this.useLightMode,
    required this.useOtherLanguageMode,
    required this.handleBrightnessChange,
    required this.handleLanguageChange,
    required this.handleColorSelect,
    required this.colorSelected,
  });

  final void Function(bool) handleBrightnessChange;
  final void Function() handleLanguageChange;
  final void Function(int) handleColorSelect;

  final bool useLightMode;
  final bool useOtherLanguageMode;
  final ColorSeed colorSelected;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final trailingActionsBody = Container(
      constraints: const BoxConstraints.tightFor(width: 250),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(AppLocalizations.of(context)!.switchLang),
              Expanded(child: Container()),
              Switch(
                  value: useOtherLanguageMode,
                  onChanged: (value) {
                    handleLanguageChange();
                  })
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text(AppLocalizations.of(context)!.brightness),
              Expanded(child: Container()),
              Switch(
                  value: useLightMode,
                  onChanged: (value) {
                    handleBrightnessChange(value);
                  })
            ],
          ),
          const Divider(),
          _ExpandedColorSeedAction(
            handleColorSelect: handleColorSelect,
            colorSelected: colorSelected,
          ),
        ],
      ),
    );
    return screenHeight > 740
        ? trailingActionsBody
        : SingleChildScrollView(child: trailingActionsBody);
  }
}

class _ExpandedColorSeedAction extends StatelessWidget {
  const _ExpandedColorSeedAction({
    required this.handleColorSelect,
    required this.colorSelected,
  });

  final void Function(int) handleColorSelect;
  final ColorSeed colorSelected;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200.0),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
          ColorSeed.values.length,
          (i) => IconButton(
            icon: const Icon(Icons.radio_button_unchecked),
            color: ColorSeed.values[i].color,
            isSelected: colorSelected.color == ColorSeed.values[i].color,
            selectedIcon: const Icon(Icons.circle),
            onPressed: () {
              handleColorSelect(i);
            },
            tooltip: ColorSeed.values[i].label,
          ),
        ),
      ),
    );
  }
}

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
          ? Footer()
          : BarTransition(
              animation: barAnimation,
              railAnimation: railAnimation,
              backgroundColor: colorScheme.surface,
              child: widget.navigationBar,
            ),
    );
  }
}

class SizeAnimation extends CurvedAnimation {
  SizeAnimation(Animation<double> parent)
      : super(
          parent: parent,
          curve: const Interval(
            0.2,
            0.8,
            curve: Curves.easeInOutCubicEmphasized,
          ),
          reverseCurve: Interval(
            0,
            0.2,
            curve: Curves.easeInOutCubicEmphasized.flipped,
          ),
        );
}

class OffsetAnimation extends CurvedAnimation {
  OffsetAnimation(Animation<double> parent)
      : super(
          parent: parent,
          curve: const Interval(
            0.4,
            1.0,
            curve: Curves.easeInOutCubicEmphasized,
          ),
          reverseCurve: Interval(
            0,
            0.2,
            curve: Curves.easeInOutCubicEmphasized.flipped,
          ),
        );
}

class RailTransition extends StatefulWidget {
  const RailTransition(
      {super.key,
      required this.animation,
      required this.backgroundColor,
      required this.child});

  final Animation<double> animation;
  final Widget child;
  final Color backgroundColor;

  @override
  State<RailTransition> createState() => _RailTransition();
}

class _RailTransition extends State<RailTransition> {
  late Animation<Offset> offsetAnimation;
  late Animation<double> widthAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // The animations are only rebuilt by this method when the text
    // direction changes because this widget only depends on Directionality.
    final bool ltr = Directionality.of(context) == TextDirection.ltr;

    widthAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(SizeAnimation(widget.animation));

    offsetAnimation = Tween<Offset>(
      begin: ltr ? const Offset(-1, 0) : const Offset(1, 0),
      end: Offset.zero,
    ).animate(OffsetAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          widthFactor: widthAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class BarTransition extends StatefulWidget {
  const BarTransition(
      {super.key,
      required this.animation,
      required this.railAnimation,
      required this.backgroundColor,
      required this.child});

  final Animation<double> animation;
  final CurvedAnimation railAnimation;
  final Color backgroundColor;
  final Widget child;

  @override
  State<BarTransition> createState() => _BarTransition();
}

class _BarTransition extends State<BarTransition> {
  late final Animation<Offset> offsetAnimation;
  late final Animation<double> heightAnimation;

  @override
  void initState() {
    super.initState();

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(OffsetAnimation(widget.animation));

    heightAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(SizeAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: heightAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class OneTwoTransition extends StatefulWidget {
  const OneTwoTransition({
    super.key,
    required this.animation,
    required this.one,
    required this.two,
  });

  final Animation<double> animation;
  final Widget one;
  final Widget two;

  @override
  State<OneTwoTransition> createState() => _OneTwoTransitionState();
}

class _OneTwoTransitionState extends State<OneTwoTransition> {
  late final Animation<Offset> offsetAnimation;
  late final Animation<double> widthAnimation;

  @override
  void initState() {
    super.initState();

    offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(OffsetAnimation(widget.animation));

    widthAnimation = Tween<double>(
      begin: 0,
      end: mediumWidthBreakpoint,
    ).animate(SizeAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: mediumWidthBreakpoint.toInt(),
          child: widget.one,
        ),
        if (widthAnimation.value.toInt() > 0) ...[
          Flexible(
            flex: widthAnimation.value.toInt(),
            child: FractionalTranslation(
              translation: offsetAnimation.value,
              child: widget.two,
            ),
          )
        ],
      ],
    );
  }
}
