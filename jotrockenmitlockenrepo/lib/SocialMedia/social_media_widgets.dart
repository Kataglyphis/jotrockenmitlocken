import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/SocialMedia/Settings/social_media_settings.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaWidgets extends StatelessWidget {
  const SocialMediaWidgets({
    super.key,
    required this.socialMediaLinksConfig,
  });

  final Map<String, ExternalLinkConfig> socialMediaLinksConfig;

  List<Widget> buildSocialMediaChildren() {
    List<Widget> socialMediaIconsWithSpacing = [];
    socialMediaLinksConfig.forEach(
        (key, socialMediaLinkConfig) => (socialMediaIconsWithSpacing.addAll([
              Padding(
                padding: const EdgeInsets.all(2.5),
                child: IconButton(
                  icon: FaIcon(socialMediaIcons[key]),
                  onPressed: () {
                    BrowserHelper.launchInBrowser(socialMediaLinkConfig);
                  },
                ),
              ),
            ])));
    return socialMediaIconsWithSpacing;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildSocialMediaChildren());
  }
}
