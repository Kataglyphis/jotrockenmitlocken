import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/one_two_transition_widget.dart';
import 'package:jotrockenmitlockenrepo/Pages/LandingPage/landing_page_entry.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/blog_page_config.dart';

class LandingPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  LandingPage({required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  List<List<Widget>> _createLandingPageChildWidgets(BuildContext context) {
    const colDivider = SizedBox(height: 10);
    List<Widget> childWidgetsLeftPage = [];
    List<Widget> childWidgetsRightPage = [];
    List<BlogPageConfig> blogPagesConfig =
        widget.appAttributes.screenConfigurations.getBlogPagesConfig();

    for (int i = 0; i < blogPagesConfig.length; i++) {
      var landingPageEntry = LandingPageEntry(
        label: blogPagesConfig[i].getLabel(context),
        routerPath: blogPagesConfig[i].getRoutingName(),
        headline: blogPagesConfig[i].getHeadline(context),
        githubRepoName: blogPagesConfig[i].getGithubRepoName(),
        githubRepo: widget
            .appAttributes.userSettings.socialMediaLinksConfig!['GitHub']!,
        description: blogPagesConfig[i].getDescription(context),
        imagePath: blogPagesConfig[i].getImagePath(),
      );
      if (blogPagesConfig[i].getAlignment() == LandingPageAlignment.left) {
        childWidgetsLeftPage += [
          colDivider,
          landingPageEntry,
          colDivider,
        ];
      } else {
        childWidgetsRightPage += [
          colDivider,
          landingPageEntry,
          colDivider,
          //widget.footer
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
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
        railAnimation: widget.appAttributes.railAnimation);
  }
}
