import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    double marginPic = 0;
    double paddingPic = 0;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return applyBoxDecoration(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.spendCoffe,
                  style: Theme.of(context).textTheme.bodyMedium),
              IconButton(
                iconSize: 57,
                icon: const FaIcon(FontAwesomeIcons.paypal),
                onPressed: () {
                  final Uri toLaunch = Uri(
                      scheme: 'https', host: 'paypal.me', path: '/JonasHeinle');
                  BrowserHelper.launchInBrowser(toLaunch);
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
          insets: EdgeInsets.all(paddingPic),
          margin: marginPic,
          borderRadius: 10,
          borderWidth: 5,
          color: Theme.of(context).colorScheme.primary);
    });
  }
}
