import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/about_me_table.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/perfect_day_chart.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/skill_table.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_pages_factory.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutMePage extends NavBarPagesFactory {
  List<List<Widget>> _createAboutMeChildPages(ColorSeed colorSelected) {
    List<Widget> childWidgetsLeftPage = [
      const AboutMeTable(),
    ];
    List<Widget> childWidgetsRightPage = [
      const PerfectDay(),
      const SizedBox(
        height: 40,
      ),
      const SkillTable(),
    ];

    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  @override
  Widget createPage(AppAttributes appFrameAttributes) {
    var aboutMePagesLeftRight =
        _createAboutMeChildPages(appFrameAttributes.colorSelected);
    return LayoutManager.createOneTwoTransisionWidget(
        aboutMePagesLeftRight[0],
        aboutMePagesLeftRight[1],
        JotrockenmitlockenFooter(
            footerPagesConfig:
                JotrockenmitLockenScreenConfigurations.getFooterPagesConfig()),
        appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout,
        appFrameAttributes.railAnimation);
  }

  @override
  NavigationDestination getNavigationDestination(BuildContext context) {
    return NavigationDestination(
      tooltip: '',
      icon: const Icon(Icons.person_outlined),
      label: AppLocalizations.of(context)!.aboutme,
      selectedIcon: const Icon(Icons.person),
    );
  }
}
