import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/blog_pages_config.dart';
import 'package:jotrockenmitlocken/Pages/nav_bar_pages_factory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/Pages/screen_configurations.dart';

class LandingPage extends NavBarPagesFactory {
  List<List<Widget>> _createLandingPageChildWidgets(bool useOtherLanguageMode) {
    const colDivider = SizedBox(height: 10);
    List<Widget> childWidgetsLeftPage = [];
    List<Widget> childWidgetsRightPage = [];
    List<BlogPagesConfig> blogPagesConfig =
        ScreenConfigurations.getBlogPagesConfig();

    for (int i = 0; i < blogPagesConfig.length; i++) {
      if (blogPagesConfig[i].landingPageAlignment ==
          LandingPageAlignment.left) {
        childWidgetsLeftPage += [
          colDivider,
          blogPagesConfig[i].landingPageEntry,
          colDivider,
        ];
      } else {
        childWidgetsRightPage += [
          colDivider,
          blogPagesConfig[i].landingPageEntry,
          colDivider,
        ];
      }
    }
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
