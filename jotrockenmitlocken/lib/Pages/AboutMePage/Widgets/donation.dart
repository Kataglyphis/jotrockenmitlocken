import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/user_settings.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              colDivider,
              const Flexible(
                child: OpenableImage(
                  displayedImage: "assets/images/paypal.jpg",
                  disableOpen: true,
                ),
              ),
              colDivider,
              const Flexible(
                child: OpenableImage(
                  displayedImage: "assets/images/Coffee-removebg.png",
                  disableOpen: false,
                ),
              ),
              colDivider,
            ],
          ),
          rowDivider,
          Text(
            AppLocalizations.of(context)!.spendCoffe + "\u2615",
            style: Theme.of(context).textTheme.titleLarge,
          )
        ]);
  }
}
