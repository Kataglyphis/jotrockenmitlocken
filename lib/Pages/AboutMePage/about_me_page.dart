import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/about_me_table.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/perfect_day_chart.dart';
import 'package:anthology/Widgets/skill_table.dart';
import 'package:anthology/Layout/ResponsiveDesign/one_two_transition_widget.dart';
import 'package:anthology/Pages/Footer/footer.dart';
import 'package:anthology/app_attributes.dart';
import 'package:anthology/user_settings.dart';

class AboutMePage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  const AboutMePage({
    super.key,
    required this.appAttributes,
    required this.footer,
  });

  @override
  State<StatefulWidget> createState() => AboutMePageState();
}

class AboutMePageState extends State<AboutMePage> {
  List<List<Widget>> _createAboutMeChildPages(
    UserSettings userSettings,
    BuildContext context,
  ) {
    String aboutMeFile = userSettings.aboutMeFileEn!;
    final locale = Localizations.localeOf(context);
    if (locale == const Locale('de')) {
      aboutMeFile = userSettings.aboutMeFileDe!;
    } else if (locale == const Locale('fr') &&
        userSettings.aboutMeFileFr != null) {
      aboutMeFile = userSettings.aboutMeFileFr!;
    }
    List<Widget> childWidgetsLeftPage = [
      AboutMeTable(userSettings: userSettings),
    ];
    List<Widget> childWidgetsRightPage = [
      const PerfectDay(),
      const SizedBox(height: 40),
      SkillTable(aboutMeFile: aboutMeFile, userSettings: userSettings),
      //widget.footer
    ];

    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  @override
  Widget build(BuildContext context) {
    final aboutMePagesLeftRight = _createAboutMeChildPages(
      widget.appAttributes.userSettings,
      context,
    );
    return OneTwoTransitionPage(
      childWidgetsLeftPage: aboutMePagesLeftRight[0],
      childWidgetsRightPage: aboutMePagesLeftRight[1],
      appAttributes: widget.appAttributes,
      footer: widget.footer,
      showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
      showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
      railAnimation: widget.appAttributes.railAnimation,
    );
  }
}
