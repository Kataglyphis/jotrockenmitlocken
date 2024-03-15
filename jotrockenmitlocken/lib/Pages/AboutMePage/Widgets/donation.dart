import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/user_settings.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/Media/Image/openable_image.dart';
import 'package:jotrockenmitlockenrepo/SocialMedia/Settings/social_media_settings.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';

class Donation extends StatefulWidget {
  const Donation({
    super.key,
  });

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  String donationKey = 'PayPal';
  @override
  Widget build(BuildContext context) {
    double marginPic = 0;
    double paddingPic = 0;
    ExternalLinkConfig paypalLinkConfig =
        UserSettings.socialMediaLinksConfig[donationKey]!;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.spendCoffe,
              style: Theme.of(context).textTheme.bodyMedium),
          IconButton(
            iconSize: 57,
            icon: FaIcon(socialMediaIcons[donationKey]!),
            onPressed: () {
              BrowserHelper.launchInBrowser(paypalLinkConfig);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                //flex: mediumWidthBreakpoint.toInt(),
                child: OpenableImage(
                  displayedImage: "assets/images/paypal.jpg",
                  disableOpen: true,
                ),
              ),
              Flexible(
                //flex: widthAnimation.value.toInt(),
                child: OpenableImage(
                  displayedImage: "assets/images/paypal.jpg",
                  disableOpen: true,
                ),
              )
            ],
          ),
        ]
        // children: [

        //     Column(
        //       children: [
        // OpenableImage(
        //   displayedImage: "assets/images/paypal.jpg",
        //   disableOpen: true,
        // ),
        //       ],

        //   ),
        // Column(
        //   children: [
        //     OpenableImage(
        //       displayedImage: "assets/images/paypal.jpg",
        //       disableOpen: true,
        //     ),
        //   ],
        // ),
        //   ],
        // ),

        // Container(
        //   width: ,
        //   child: const Column(
        //     children: [
        //       OpenableImage(
        //         displayedImage: "assets/images/Coffee-removebg.png",
        //         disableOpen: true,
        //       ),
        //     ],
        //   ),
        // ),
        //   colDivider,
        // ],
        //),
        // ],
        );
  }
}
