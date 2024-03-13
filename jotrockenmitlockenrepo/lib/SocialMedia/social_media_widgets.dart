import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaWidgets extends StatelessWidget {
  SocialMediaWidgets({super.key, required this.iconSize});

  final Map<String, ExternalLinkConfig> socialMediaLinksConfig = {
    'Facebook':
        ExternalLinkConfig(host: 'www.facebook.com', path: 'jonas.heinle/'),
    'GitHub': ExternalLinkConfig(host: 'www.github.com', path: 'Kataglyphis'),
    'YouTube': ExternalLinkConfig(
        host: 'www.youtube.com', path: 'channel/UC3LZiH4sZzzaVBCUV8knYeg'),
    'X': ExternalLinkConfig(host: 'www.twitter.com', path: 'Cataglyphis_'),
    'LinkedIn': ExternalLinkConfig(
        host: 'www.linkedin.com', path: 'in/jonas-heinle-0b2a301a0/'),
    'Instagram': ExternalLinkConfig(
        host: 'www.instagram.com', path: 'jotrockenmitlocken'),
  };

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
