import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_pages_creator.dart';
import 'package:jotrockenmitlockenrepo/Layout/grid_creator.dart';
import 'package:jotrockenmitlockenrepo/SocialMedia/social_media_widgets.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

abstract class Footer extends StatefulWidget {
  const Footer({
    super.key,
    required this.footerPagesConfig,
  });

  final List<FooterPagesConfig> footerPagesConfig;
}

abstract class FooterState extends State<Footer> {
  final int maxNumFooterPageTextButtonsPerRow = 3;
  final int maxExternalLinksTextButtonsPerRow = 1;

  @override
  void initState() {
    super.initState();
  }

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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            )))
        .toList();

    return GridCreator.createAdaptiveGridOfWidgets(
        align, maxNumFooterPageTextButtonsPerRow, footerPagesButtons);
  }

  String getExternalLinksTitle();
  List<ExternalLinkConfig> getExternalLinks();

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
                final Uri toLaunch = Uri(
                    scheme: 'https',
                    host: externalLinkConfig.host,
                    path: externalLinkConfig.path);
                BrowserHelper.launchInBrowser(toLaunch);
              },
              style: Theme.of(context).textButtonTheme.style,
              child: Text(
                externalLinkConfig.host,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
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

  String getLiabilityText();

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
        SocialMediaWidgets(iconSize: 14),
        Row(
            mainAxisAlignment: align,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getLiabilityText(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth < mediumWidthBreakpoint) {
      return Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          createTextButtons(),
          const SizedBox(
            height: 30,
          ),
          createSocialIconsAndLiabilityWidgets(),
          const SizedBox(
            height: 30,
          ),
          createTextButtonsForExternalLinks(),
          const SizedBox(
            height: 30,
          ),
        ],
      );
    } else {
      return SizedBox(
        height: 150.0,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),

            // const Expanded(
            //     child: Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [],
            // )),
            // const Expanded(
            //     child: Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [],
            // )),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 30,
                ),
                createTextButtons(),
                const SizedBox(
                  width: 30,
                ),
                createSocialIconsAndLiabilityWidgets(),
                const SizedBox(
                  width: 30,
                ),
                createTextButtonsForExternalLinks(),
              ],
            ),
            // const Expanded(
            //     child: Column(
            //   children: [],
            // )),

            // const Expanded(
            //     child: Column(
            //   children: [],
            // )),
          ],
        ),
      );
    }
  }
}
