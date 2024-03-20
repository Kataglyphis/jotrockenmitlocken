import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_config.dart';
import 'package:jotrockenmitlockenrepo/SocialMedia/social_media_widgets.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:jotrockenmitlockenrepo/user_settings.dart';

class FooterSocialIconsAndLiability extends StatefulWidget {
  const FooterSocialIconsAndLiability(
      {super.key, required this.footerConfig, required this.userSettings});
  final FooterConfig footerConfig;
  final UserSettings userSettings;
  @override
  State<StatefulWidget> createState() => FooterSocialIconsAndLiabilityState();
}

class FooterSocialIconsAndLiabilityState
    extends State<FooterSocialIconsAndLiability> {
  @override
  Widget build(BuildContext context) {
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
          socialMediaLinksConfig: widget.userSettings.socialMediaLinksConfig!,
        ),
        Padding(
          padding: const EdgeInsets.all(1),
          child: Row(
              mainAxisAlignment: align,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.footerConfig.getLiabilityText(context),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ]),
        )
      ],
    );
  }
}
