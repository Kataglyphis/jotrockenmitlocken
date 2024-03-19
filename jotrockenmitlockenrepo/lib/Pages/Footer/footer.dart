import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_pages_creator.dart';
import 'package:jotrockenmitlockenrepo/Layout/grid_creator.dart';
import 'package:jotrockenmitlockenrepo/SocialMedia/social_media_widgets.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:jotrockenmitlockenrepo/user_settings.dart';

abstract class Footer extends StatefulWidget {
  const Footer({
    super.key,
    required this.footerPagesConfig,
    required this.userSettings,
  });

  final List<FooterPagesConfig> footerPagesConfig;
  final UserSettings userSettings;
}

abstract class FooterState extends State<Footer> {
  final int maxNumFooterPageTextButtonsPerRow = 3;
  final int maxExternalLinksTextButtonsPerRow = 1;
  final double footerHeight = 150.0;

  String getLiabilityText();
  String getExternalLinksTitle();
  Map<String, ExternalLinkConfig> getUserLevelSocialMediaLinksConfig();
  List<ExternalLinkConfig> getExternalLinks();

  Widget createTextButtons() {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.start;
    if (currentWidth < mediumWidthBreakpoint) {
      align = MainAxisAlignment.center;
    }

    List<TextButton> footerPagesButtons = widget.footerPagesConfig
        .map((footerPageConfig) => (TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodyMedium),
              onPressed: () {
                context.go(footerPageConfig.routingName);
              },
              child: Text(
                textAlign: TextAlign.center,
                footerPageConfig.getHeading(context),
              ),
            )))
        .toList();

    return GridCreator.createAdaptiveGridOfWidgets(
        align, maxNumFooterPageTextButtonsPerRow, footerPagesButtons);
  }

  Widget createTextButtonsForExternalLinks() {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.center;
    if (currentWidth < mediumWidthBreakpoint) {
      align = MainAxisAlignment.center;
    }

    List<ExternalLinkConfig> externalLinksConfig = getExternalLinks();
    List<TextButton> footerExternalLinksButtons = externalLinksConfig
        .map((externalLinkConfig) => (TextButton(
              onPressed: () {
                BrowserHelper.launchInBrowser(externalLinkConfig);
              },
              style: Theme.of(context).textButtonTheme.style,
              child: Text(
                externalLinkConfig.host,
              ),
            )))
        .toList();

    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                textAlign: TextAlign.center,
                getExternalLinksTitle(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          GridCreator.createAdaptiveGridOfWidgets(align,
              maxExternalLinksTextButtonsPerRow, footerExternalLinksButtons),
        ]);
  }

  Widget createSocialIconsAndLiabilityWidgets() {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.start;
    if (currentWidth < mediumWidthBreakpoint) {
      align = MainAxisAlignment.center;
    }
    return Column(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SocialMediaWidgets(
          socialMediaLinksConfig: getUserLevelSocialMediaLinksConfig(),
        ),
        Padding(
          padding: const EdgeInsets.all(1),
          child: Row(
              mainAxisAlignment: align,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getLiabilityText(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth < mediumWidthBreakpoint) {
      return Column(
        children: [
          rowDivider,
          createTextButtons(),
          rowDivider,
          createSocialIconsAndLiabilityWidgets(),
          rowDivider,
          createTextButtonsForExternalLinks(),
          rowDivider,
        ],
      );
    } else {
      return SizedBox(
        height: footerHeight,
        child: Column(
          children: [
            rowDivider,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                colDivider,
                createTextButtons(),
                colDivider,
                createSocialIconsAndLiabilityWidgets(),
                colDivider,
                createTextButtonsForExternalLinks(),
              ],
            ),
          ],
        ),
      );
    }
  }
}
