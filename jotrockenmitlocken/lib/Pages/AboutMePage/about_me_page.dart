import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/about_me_table.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/perfect_day_chart.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/skill_table.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/one_two_transition_widget.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_pages_factory.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/user_settings.dart';

class AboutMePage extends NavBarPagesFactory {
  List<List<Widget>> _createAboutMeChildPages(UserSettings userSettings,
      ColorSeed colorSelected, BuildContext context) {
    String aboutMeFile = userSettings.aboutMeFileEn!;
    if (Localizations.localeOf(context) == const Locale('de')) {
      aboutMeFile = userSettings.aboutMeFileDe!;
    }
    List<Widget> childWidgetsLeftPage = [
      AboutMeTable(userSettings: userSettings),
    ];
    List<Widget> childWidgetsRightPage = [
      const PerfectDay(),
      const SizedBox(
        height: 40,
      ),
      SkillTable(
        aboutMeFile: aboutMeFile,
        userSettings: userSettings,
      ),
    ];

    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  @override
  Widget createPage(AppAttributes appAttributes, BuildContext context) {
    var aboutMePagesLeftRight = _createAboutMeChildPages(
        appAttributes.userSettings, appAttributes.colorSelected, context);
    return OneTwoTransitionPage(
        childWidgetsLeftPage: aboutMePagesLeftRight[0],
        childWidgetsRightPage: aboutMePagesLeftRight[1],
        footer: Footer(
          footerPagesConfig:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: appAttributes.userSettings,
          footerConfig: appAttributes.footerConfig,
        ),
        showMediumSizeLayout: appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: appAttributes.showLargeSizeLayout,
        railAnimation: appAttributes.railAnimation);
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
