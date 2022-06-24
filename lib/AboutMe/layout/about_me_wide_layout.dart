import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/donation.dart';
import 'package:jotrockenmitlocken/AboutMe/socialMedia/social_media_widgets.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Navbar/navbar.dart';
import '../about_me_table.dart';

class AboutMeWideLayout extends StatelessWidget {
  const AboutMeWideLayout({Key? key}) : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const NavBar(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: media.size.width,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    "assets/images/maxresdefault.jpg",
                    width: media.size.width,
                  ),
                  Positioned(
                    bottom: -50,
                    right: media.size.width * 0.4,
                    child: CircleAvatar(
                      radius: media.size.width * 0.1,
                      backgroundImage: AssetImage(
                        "assets/images/Me.jpg",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          const Text(
            "Jonas Heinle",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: Colors.black),
          ),
          const Text(
            "\nrenderdude@jotrockenmitlocken.de",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: Colors.black),
          ),
          SizedBox(height: 30),
          SocialMediaWidgets(),
          SizedBox(
            height: 20,
          ),
          AboutMeTable(),
          SizedBox(
            height: 20,
          ),
          Donation(),
        ],
      ),
    );
  }
}
