import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/Widgets/component_group_decoration.dart';
import 'package:jotrockenmitlockenrepo/Helper/browser_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPageEntry extends StatefulWidget {
  LandingPageEntry({
    super.key,
    required this.label,
    required this.routerPath,
    required this.headline,
    required this.imagePath,
    required this.githubRepo,
  });

  String label;
  String routerPath;
  String headline;
  String imagePath;
  String githubRepo;

  @override
  State<LandingPageEntry> createState() => _LandingPageEntryState();
}

class _LandingPageEntryState extends State<LandingPageEntry> {
  bool isDisabled = false;
  @override
  Widget build(BuildContext context) {
    const colDivider = SizedBox(height: 10);
    return ComponentGroupDecoration(label: widget.label, children: <Widget>[
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
                  path: 'Kataglyphis/${widget.githubRepo}');
              BrowserHelper.launchInBrowser(toLaunch);
            },
          ),
          Text(
            AppLocalizations.of(context)!.playgroundDescription +
                "\n" +
                widget.githubRepo,
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
                    context.go(widget.routerPath);
                  },
            child: Text(
              widget.headline,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
      colDivider,
      applyBoxDecoration(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.asset(widget.imagePath),
          ),
          borderRadius: 0,
          borderWidth: 5,
          color: Theme.of(context).colorScheme.primary),
      colDivider
    ]);
  }
}
