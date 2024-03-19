import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/component_group_decoration.dart';
import 'package:jotrockenmitlockenrepo/Media/Image/openable_image.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';
import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:jotrockenmitlocken/user_settings.dart';

class LandingPageEntry extends StatefulWidget {
  const LandingPageEntry(
      {super.key,
      required this.label,
      required this.routerPath,
      required this.headline,
      required this.imagePath,
      required this.githubRepoName,
      required this.githubRepo,
      required this.description,
      re});
  final String label;
  final String routerPath;
  final String headline;
  final String imagePath;
  final String githubRepoName;
  final String description;
  final ExternalLinkConfig githubRepo;

  @override
  State<LandingPageEntry> createState() => LandingPageEntryState();
}

class LandingPageEntryState extends State<LandingPageEntry> {
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(label: widget.label, children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.github),
            onPressed: () {
              BrowserHelper.launchInBrowser(widget.githubRepo);
            },
          ),
          colDivider,
          Text(
            "${widget.description}\n${widget.githubRepoName}",
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
      rowDivider,
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
      rowDivider,
      OpenableImage(
        displayedImage: widget.imagePath,
        disableOpen: true,
      ),
      rowDivider
    ]);
  }
}
