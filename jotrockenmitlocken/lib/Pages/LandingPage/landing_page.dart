import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/ai_playground.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/rendering_playground.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/nav_bar_pages_factory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends NavBarPagesFactory {
  List<List<Widget>> _createLandingPageChildWidgets(bool useOtherLanguageMode) {
    const colDivider = SizedBox(height: 10);
    List<Widget> childWidgetsLeftPage = [
      colDivider,
      const AIPlayground(),
      colDivider,
    ];
    List<Widget> childWidgetsRightPage = [
      colDivider,
      const RenderingPlayground(),
    ];
    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    var homePagesLeftRight = _createLandingPageChildWidgets(
      appFrameAttributes.useOtherLanguageMode,
    );
    return LayoutManager.createOneTwoTransisionWidget(
        homePagesLeftRight[0],
        homePagesLeftRight[1],
        appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout,
        appFrameAttributes.railAnimation);
  }

  @override
  NavigationDestination getNavigationDestination(BuildContext context) {
    return NavigationDestination(
      tooltip: '',
      icon: const Icon(Icons.house_outlined),
      label: AppLocalizations.of(context)!.homepage,
      selectedIcon: const Icon(Icons.house),
    );
  }
}
