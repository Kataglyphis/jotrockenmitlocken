import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/browser_helper.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaWidgets extends StatelessWidget {
  const SocialMediaWidgets({super.key});

  List<Widget> buildSocialMediaChildren(double iconSize) {
    return [
      IconButton(
        iconSize: iconSize,
        icon: const FaIcon(FontAwesomeIcons.facebook),
        // color: Colors.black,
        onPressed: () {
          final Uri toLaunch = Uri(
              scheme: 'https', host: 'www.facebook.com', path: 'jonas.heinle/');
          BrowserHelper.launchInBrowser(toLaunch);
        },
      ),
      SizedBox(
        width: iconSize / 2,
      ),
      IconButton(
        iconSize: iconSize,
        icon: const FaIcon(FontAwesomeIcons.github),
        // color: Colors.black,
        onPressed: () {
          final Uri toLaunch =
              Uri(scheme: 'https', host: 'github.com', path: 'Kataglyphis');
          BrowserHelper.launchInBrowser(toLaunch);
        },
      ),
      SizedBox(
        width: iconSize / 2,
      ),
      IconButton(
        iconSize: iconSize,
        icon: const FaIcon(FontAwesomeIcons.youtube),
        // color: Colors.black,
        onPressed: () {
          final Uri toLaunch = Uri(
              scheme: 'https',
              host: 'www.youtube.com',
              path: 'channel/UC3LZiH4sZzzaVBCUV8knYeg');
          BrowserHelper.launchInBrowser(toLaunch);
        },
      ),
      SizedBox(
        width: iconSize / 2,
      ),
      IconButton(
        iconSize: iconSize,
        icon: const FaIcon(FontAwesomeIcons.twitter),
        // color: Colors.black,
        onPressed: () {
          final Uri toLaunch =
              Uri(scheme: 'https', host: 'twitter.com', path: 'Cataglyphis_');
          BrowserHelper.launchInBrowser(toLaunch);
        },
      ),
      SizedBox(
        width: iconSize / 2,
      ),
      IconButton(
        iconSize: iconSize,
        icon: const FaIcon(FontAwesomeIcons.linkedin),
        // color: Colors.black,
        onPressed: () {
          final Uri toLaunch = Uri(
              scheme: 'https',
              host: 'linkedin.com',
              path: 'in/jonas-heinle-0b2a301a0/');
          BrowserHelper.launchInBrowser(toLaunch);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > largeWidthBreakpoint) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildSocialMediaChildren(54));
      } else {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildSocialMediaChildren(40));
      }
    });
  }
}
