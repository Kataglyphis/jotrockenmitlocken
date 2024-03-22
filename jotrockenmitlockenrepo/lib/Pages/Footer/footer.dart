import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/Sections/footer_external_links.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/Sections/footer_pages_text_buttons.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/Sections/footer_social_icons_and_liability.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_page_config.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:jotrockenmitlockenrepo/user_settings.dart';

class Footer extends StatefulWidget {
  const Footer({
    super.key,
    required this.footerPagesConfigs,
    required this.userSettings,
    required this.footerConfig,
  });

  final List<FooterPageConfig> footerPagesConfigs;
  final FooterConfig footerConfig;
  final UserSettings userSettings;

  @override
  State<StatefulWidget> createState() => FooterState();
}

class FooterState extends State<Footer> {
  final double footerHeight = 150.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth < mediumWidthBreakpoint) {
      return Column(
        children: [
          rowDivider,
          FooterPagesTextButtons(
            footerPagesConfig: widget.footerPagesConfigs,
          ),
          rowDivider,
          FooterSocialIconsAndLiability(
            footerConfig: widget.footerConfig,
            userSettings: widget.userSettings,
          ),
          rowDivider,
          FooterExternalLinks(
            footerConfig: widget.footerConfig,
            userSettings: widget.userSettings,
          ),
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
                FooterPagesTextButtons(
                    footerPagesConfig: widget.footerPagesConfigs),
                colDivider,
                FooterSocialIconsAndLiability(
                  footerConfig: widget.footerConfig,
                  userSettings: widget.userSettings,
                ),
                colDivider,
                FooterExternalLinks(
                  footerConfig: widget.footerConfig,
                  userSettings: widget.userSettings,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
