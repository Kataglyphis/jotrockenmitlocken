import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/about_me_table.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/perfect_day_chart.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/skill_table.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/one_two_transition_widget.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:jotrockenmitlockenrepo/user_settings.dart';

class AboutMePage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  AboutMePage({required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => AboutMePageState();
}

class AboutMePageState extends State<AboutMePage> {
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
      widget.footer
    ];

    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  @override
  Widget build(BuildContext context) {
    var aboutMePagesLeftRight = _createAboutMeChildPages(
        widget.appAttributes.userSettings,
        widget.appAttributes.colorSelected,
        context);
    return OneTwoTransitionPage(
        childWidgetsLeftPage: aboutMePagesLeftRight[0],
        childWidgetsRightPage: aboutMePagesLeftRight[1],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
        railAnimation: widget.appAttributes.railAnimation);
  }
}
