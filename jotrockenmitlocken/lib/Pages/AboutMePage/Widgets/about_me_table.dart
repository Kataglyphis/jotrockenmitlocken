import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/donation.dart';
import 'package:jotrockenmitlockenrepo/Media/Image/openable_image.dart';
import 'package:jotrockenmitlocken/user_settings.dart';
import 'package:jotrockenmitlockenrepo/socialMedia/social_media_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutMeTable extends StatefulWidget {
  const AboutMeTable({
    super.key,
  });

  @override
  AboutMeTableState createState() => AboutMeTableState();
}

class AboutMeTableState extends State<AboutMeTable> {
  AboutMeTableState({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const OpenableImage(
          displayedImage: UserSettings.assetPathImgOfMe,
          disableOpen: true,
        ),
        colDivider,
        Text(
          UserSettings.myName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        colDivider,
        Text(
          AppLocalizations.of(context)!.shortDescriptionTextMyPersona,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        colDivider,
        SocialMediaWidgets(
          socialMediaLinksConfig: UserSettings.socialMediaLinksConfig,
        ),
        colDivider,
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.titleLarge,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            onPressed: () async {
              String email = Uri.encodeComponent(UserSettings.businessEmail);
              String subject = Uri.encodeComponent("Awesome job offer");
              String body = Uri.encodeComponent("Hi ${UserSettings.firstName}");
              //print(subject); //output: Hello%20Flutter
              Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
              if (await launchUrl(mail)) {
                //email app opened
              } else {
                //email app is not opened
              }
            },
            child: Text(
              AppLocalizations.of(context)!.mailMe,
            )),
        colDivider,
        Text(
          UserSettings.businessEmail,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        colDivider,
        Text(
          UserSettings.myQuotation,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        colDivider,
        const Donation(),
        colDivider,
        Text(
          "I love to cURL",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          iconSize: 40,
          icon: const FaIcon(FontAwesomeIcons.dumbbell),
          // color: Colors.black,
          onPressed: () {},
        ),
        colDivider,
      ],
    );
  }
}
