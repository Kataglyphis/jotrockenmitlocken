import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Layout/adaptive_grid.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_config.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:jotrockenmitlockenrepo/user_settings.dart';

class FooterExternalLinks extends StatefulWidget {
  const FooterExternalLinks(
      {super.key, required this.footerConfig, required this.userSettings});
  final FooterConfig footerConfig;
  final UserSettings userSettings;
  @override
  State<StatefulWidget> createState() => FooterExternalLinksState();
}

class FooterExternalLinksState extends State<FooterExternalLinks> {
  final int maxExternalLinksTextButtonsPerRow = 1;
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    var align = MainAxisAlignment.center;
    if (currentWidth < mediumWidthBreakpoint) {
      align = MainAxisAlignment.center;
    }

    List<ExternalLinkConfig> externalLinksConfig =
        widget.footerConfig.getExternalLinks(context);
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
                widget.footerConfig.getExternalLinksTitle(context),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          AdaptiveGrid(
            maxgridWidgetsPerRow: maxExternalLinksTextButtonsPerRow,
            gridWidgets: footerExternalLinksButtons,
            rowAlignment: align,
          ),
        ]);
  }
}
