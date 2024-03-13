import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaWidgets extends StatelessWidget {
  SocialMediaWidgets({
    super.key,
    required this.iconSize,
    required this.socialMediaLinksConfig,
  });

  final Map<String, ExternalLinkConfig> socialMediaLinksConfig;

  final Map<String, IconData> socialMediaIcons = {
    'Facebook': FontAwesomeIcons.facebook,
    'GitHub': FontAwesomeIcons.github,
    'YouTube': FontAwesomeIcons.youtube,
    'X': FontAwesomeIcons.xTwitter,
    'LinkedIn': FontAwesomeIcons.linkedin,
    'Instagram': FontAwesomeIcons.instagram,
  };

  final double iconSize;
  List<Widget> buildSocialMediaChildren(double iconSize) {
    List<Widget> socialMediaIconsWithSpacing = [];
    socialMediaLinksConfig.forEach(
        (key, socialMediaLinkConfig) => (socialMediaIconsWithSpacing.addAll([
              IconButton(
                iconSize: iconSize,
                icon: FaIcon(socialMediaIcons[key]),
                // color: Colors.black,
                onPressed: () {
                  final Uri toLaunch = Uri(
                      scheme: 'https',
                      host: socialMediaLinkConfig.host,
                      path: socialMediaLinkConfig.path);
                  BrowserHelper.launchInBrowser(toLaunch);
                },
              ),
              SizedBox(
                width: iconSize / 2,
              ),
            ])));
    return socialMediaIconsWithSpacing;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > largeWidthBreakpoint) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildSocialMediaChildren(iconSize));
      } else {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildSocialMediaChildren(iconSize));
      }
    });
  }
}
