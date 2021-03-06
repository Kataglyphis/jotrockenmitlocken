import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/donation.dart';
import 'package:jotrockenmitlocken/AboutMe/socialMedia/social_media_widgets.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jotrockenmitlocken/constants.dart';

import '../../Navbar/navbar.dart';
import '../about_me_table.dart';

class AboutMeNarrowLayout extends StatelessWidget {
  const AboutMeNarrowLayout({Key? key}) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
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
                  right: media.size.width * 0.35,
                  child: CircleAvatar(
                    radius: media.size.width * 0.15,
                    backgroundImage: AssetImage(
                      "assets/images/Me.jpg",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          SocialMediaWidgets(),
          const Text(
            "Jonas Heinle",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black),
          ),
          const Text(
            "\nrenderdude@jotrockenmitlocken.de",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black),
          ),
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
