import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/donation.dart';
import 'package:jotrockenmitlocken/AboutMe/socialMedia/social_media_widgets.dart';
import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jotrockenmitlocken/font_helper.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutMeTable extends StatefulWidget {
  const AboutMeTable({
    super.key,
    required this.useOtherLanguageMode,
    required this.colorSelected,
  });

  final ColorSeed colorSelected;
  final bool useOtherLanguageMode;

  @override
  AboutMeTableState createState() => AboutMeTableState();
}

class AboutMeTableState extends State<AboutMeTable> {
  AboutMeTableState({
    Key? key,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double currentWidth = MediaQuery.of(context).size.width;
    // init all as it would be rendered on phone
    double picWidth = currentWidth * 0.9;
    double marginPic = 0;
    double paddingPic = 0;
    const double borderRadiusPic = 10;
    if (currentWidth >= narrowScreenWidthThreshold &&
        currentWidth <= largeWidthBreakpoint) {
      picWidth = currentWidth * 0.6;
      marginPic = 0;
      paddingPic = 0;
    } else if (currentWidth >= largeWidthBreakpoint) {
      picWidth = currentWidth * 0.4;
      marginPic = 0;
      paddingPic = 0;
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: picWidth,
            child: applyBoxDecoration(
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: const FadeInImage(
                    filterQuality: FilterQuality.medium,
                    placeholder: AssetImage(
                        "assets/images/Bewerbungsbilder/a95a64ca_runterskaliert.jpg"),
                    image: AssetImage(
                      "assets/images/Bewerbungsbilder/a95a64ca_runterskaliert.jpg",
                    ),
                  ),
                ),
                EdgeInsets.all(paddingPic),
                marginPic,
                borderRadiusPic,
                5,
                widget.colorSelected.color),
          ),
          const SizedBox(height: 10),
          Text(
            "Jonas Heinle",
            textAlign: TextAlign.center,
            style: FontHelper.getTextStyleHeadings(context),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.shortDescriptionTextMyPersona,
            textAlign: TextAlign.center,
            style: FontHelper.getTextStyle(context),
          ),
          const SizedBox(
            height: 10,
          ),
          const SocialMediaWidgets(),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
              onPressed: () async {
                String email =
                    Uri.encodeComponent("cataglyphis@jotrockenmitlocken.de");
                String subject = Uri.encodeComponent("Awesome job offer");
                String body = Uri.encodeComponent("Hi Jonas");
                //print(subject); //output: Hello%20Flutter
                Uri mail =
                    Uri.parse("mailto:$email?subject=$subject&body=$body");
                if (await launchUrl(mail)) {
                  //email app opened
                } else {
                  //email app is not opened
                }
              },
              child: Text(
                AppLocalizations.of(context)!.mailMe,
              )),
          const SizedBox(height: 10),
          Text(
            "cataglyphis@jotrockenmitlocken.de",
            textAlign: TextAlign.center,
            style: FontHelper.getTextStyle(context),
          ),
          const SizedBox(height: 10),
          Text(
            "»As soon as it works, no-one calls it AI anymore.« (John McCarthy)",
            textAlign: TextAlign.center,
            style: FontHelper.getTextStyle(context),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: picWidth,
            child: Donation(
              colorSelected: widget.colorSelected,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "I love to cURL",
            textAlign: TextAlign.center,
            style: FontHelper.getTextStyleHeadings(context),
          ),
          IconButton(
            iconSize: 40,
            icon: const FaIcon(FontAwesomeIcons.dumbbell),
            // color: Colors.black,
            onPressed: () {},
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}
