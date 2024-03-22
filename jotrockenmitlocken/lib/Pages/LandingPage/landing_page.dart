import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/one_two_transition_widget.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlocken/Pages/blog_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';

class LandingPage extends StatefulWidget {
  final AppAttributes appAttributes;
  LandingPage({required this.appAttributes});

  @override
  State<StatefulWidget> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  List<List<Widget>> _createLandingPageChildWidgets(BuildContext context) {
    const colDivider = SizedBox(height: 10);
    List<Widget> childWidgetsLeftPage = [];
    List<Widget> childWidgetsRightPage = [];
    List<BlogPage> blogPagesConfig =
        JotrockenmitLockenScreenConfigurations.getBlogPagesConfig();

    for (int i = 0; i < blogPagesConfig.length; i++) {
      if (blogPagesConfig[i].landingPageAlignment ==
          LandingPageAlignment.left) {
        childWidgetsLeftPage += [
          colDivider,
          blogPagesConfig[i]
              .landingPageEntryFactory
              .createLandingPageEntry(widget.appAttributes, context),
          colDivider,
        ];
      } else {
        childWidgetsRightPage += [
          colDivider,
          blogPagesConfig[i]
              .landingPageEntryFactory
              .createLandingPageEntry(widget.appAttributes, context),
          colDivider,
        ];
      }
    }
    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  @override
  Widget build(BuildContext context) {
    var homePagesLeftRight = _createLandingPageChildWidgets(context);
    return OneTwoTransitionPage(
        childWidgetsLeftPage: homePagesLeftRight[0],
        childWidgetsRightPage: homePagesLeftRight[1],
        footer: Footer(
          footerPagesConfigs:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: widget.appAttributes.userSettings,
          footerConfig: widget.appAttributes.footerConfig,
        ),
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
        railAnimation: widget.appAttributes.railAnimation);
  }
}
