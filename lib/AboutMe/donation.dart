import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:async';

class Donation extends StatelessWidget {
  const Donation({Key? key}) : super(key: key);

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
    return Column(
      children: [
        const Text(
          "You can get me some coffee. ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
        ),
        IconButton(
          iconSize: 57,
          icon: const FaIcon(FontAwesomeIcons.paypal),
          color: Colors.black,
          onPressed: () {
            final Uri toLaunch = Uri(
                scheme: 'https',
                host: 'www.paypal.com',
                path: 'donate/?hosted_button_id=BX9AVVES2P9LN');
            _launchInBrowser(toLaunch);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Image.asset("assets/images/Paypal_QR_Code.png", width: 200),
        ),
      ],
    );
  }
}
