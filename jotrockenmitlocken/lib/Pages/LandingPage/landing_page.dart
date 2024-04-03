import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/one_two_transition_widget.dart';
import 'package:jotrockenmitlockenrepo/Pages/LandingPage/landing_page_entry.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/blog_page_config.dart';

class LandingPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  const LandingPage(
      {super.key, required this.appAttributes, required this.footer});

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

    ExternalLinkConfig gitHub =
        widget.appAttributes.userSettings.socialMediaLinksConfig!['GitHub']!;
    for (int i = 0; i < blogPagesConfig.length; i++) {
      ExternalLinkConfig githubRepo = ExternalLinkConfig(
          host: gitHub.host, path: gitHub.path + blogPagesConfig[i].githubRepo);

      var landingPageEntry = LandingPageEntry(
        lastModified:
            "${AppLocalizations.of(context)!.lastModified} ${blogPagesConfig[i].lastModified}",
        currentLocale: Localizations.localeOf(context),
        fileTitle: blogPagesConfig[i].fileTitle,
        fileAdditionalInfo: blogPagesConfig[i].fileAdditionalInfo,
        fileBaseDir: blogPagesConfig[i].fileBaseDir,
        labelEN: blogPagesConfig[i].shortDescriptionEN,
        labelDE: blogPagesConfig[i].shortDescriptionDE,
        routerPath: blogPagesConfig[i].getRoutingName(),
        headline: AppLocalizations.of(context)!.visitBlogEntry,
        githubRepo: githubRepo,
        description: AppLocalizations.of(context)!.playgroundDescription,
        imagePath: blogPagesConfig[i].landingPageEntryImagePath,
        imageCaptioning: blogPagesConfig[i].landingPageEntryImageCaptioning,
      );
      if (blogPagesConfig[i].landingPageAlignment == "left") {
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
