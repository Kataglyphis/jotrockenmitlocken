import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/Widgets/component_group_decoration.dart';
import 'package:jotrockenmitlockenrepo/Media/Image/openable_image.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';
import 'package:jotrockenmitlocken/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class LandingPageEntry extends StatefulWidget {
  const LandingPageEntry({
    super.key,
  });

  @override
  State<LandingPageEntry> createState();
}

abstract class LandingPageEntryState extends State<LandingPageEntry> {
  bool isDisabled = false;

  String getLabel();
  String getRouterPath();
  String getHeadline();
  String getImagePath();
  String getGithubRepo();

  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(label: getLabel(), children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.github),
            onPressed: () {
              BrowserHelper.launchInBrowser(
                  UserSettings.appendRepoToGitHubUserLink(getGithubRepo()));
            },
          ),
          colDivider,
          Text(
            "${AppLocalizations.of(context)!.playgroundDescription}\n${getGithubRepo()}",
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton.tonal(
            onPressed: isDisabled
                ? null
                : () {
                    context.go(getRouterPath());
                  },
            child: Text(
              getHeadline(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
      colDivider,
      OpenableImage(
        displayedImage: getImagePath(),
        disableOpen: true,
      ),
      colDivider
    ]);
  }
}
