import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/Widgets/component_group_decoration.dart';
import 'package:jotrockenmitlockenrepo/Helper/browser_helper.dart';
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
    const colDivider = SizedBox(height: 10);
    return ComponentGroupDecoration(label: getLabel(), children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 50,
            icon: const FaIcon(FontAwesomeIcons.github),
            // color: Colors.black,
            onPressed: () {
              final Uri toLaunch = Uri(
                  scheme: 'https',
                  host: 'github.com',
                  path: 'Kataglyphis/${getGithubRepo()}');
              BrowserHelper.launchInBrowser(toLaunch);
            },
          ),
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
      applyBoxDecoration(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.asset(getImagePath()),
          ),
          borderRadius: 0,
          borderWidth: 5,
          color: Theme.of(context).colorScheme.primary),
      colDivider
    ]);
  }
}
