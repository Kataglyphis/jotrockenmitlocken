import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Widgets/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Donation extends StatefulWidget {
  const Donation({
    super.key,
    required this.colorSelected,
  });
  final ColorSeed colorSelected;

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
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
    double marginPic = 0;
    double paddingPic = 0;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return applyBoxDecoration(
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.spendCoffe,
                  style: FontHelper.getTextStyle(context)),
              IconButton(
                iconSize: 57,
                icon: const FaIcon(FontAwesomeIcons.paypal),
                onPressed: () {
                  final Uri toLaunch = Uri(
                      scheme: 'https', host: 'paypal.me', path: '/JonasHeinle');
                  _launchInBrowser(toLaunch);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.1,
                  ),
                  Image.asset(
                    "assets/images/paypal.jpg",
                    width: constraints.maxWidth * 0.3,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.1,
                  ),
                  Image.asset(
                    "assets/images/Coffee-removebg.png",
                    width: constraints.maxWidth * 0.3,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.1,
                  ),
                ],
              ),
            ],
          ),
          EdgeInsets.all(paddingPic),
          marginPic,
          10,
          5,
          widget.colorSelected.color);
    });
  }
}
