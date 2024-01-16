import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:async';

class Donation extends StatelessWidget {
  TextStyle textStyle;
  Donation(this.textStyle, {Key? key}) : super(key: key);

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
        Text("You can get me some coffee. ", style: textStyle),
        IconButton(
          iconSize: 57,
          icon: const FaIcon(FontAwesomeIcons.paypal),
          onPressed: () {
            final Uri toLaunch = Uri(
                scheme: 'https',
                host: 'paypal.com',
                path: '/donate/?hosted_button_id=BX9AVVES2P9LN');
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
