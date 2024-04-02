import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/component_group_decoration.dart';
import 'package:jotrockenmitlockenrepo/Media/Image/openable_image.dart';
import 'package:jotrockenmitlockenrepo/Url/browser_helper.dart';
import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';

class LandingPageEntry extends StatefulWidget {
  const LandingPageEntry({
    super.key,
    required this.currentLocale,
    required this.labelEN,
    required this.labelDE,
    required this.routerPath,
    required this.headline,
    required this.imagePath,
    required this.githubRepo,
    required this.description,
    this.imageCaptioning,
  });
  final String labelEN;
  final String labelDE;
  final String routerPath;
  final String headline;
  final String imagePath;
  final String description;
  final ExternalLinkConfig githubRepo;
  final Locale currentLocale;
  final String? imageCaptioning;

  @override
  State<LandingPageEntry> createState() => LandingPageEntryState();
}

class LandingPageEntryState extends State<LandingPageEntry> {
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> undecoratedChilds = [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
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
              "${widget.description}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
      // //rowDivider,
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
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
      ),
      rowDivider,
      OpenableImage(
        displayedImage: widget.imagePath,
        disableOpen: true,
        imageCaptioning: widget.imageCaptioning,
      ),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ComponentGroupDecoration(
              label: (widget.currentLocale == const Locale("de"))
                  ? widget.labelDE
                  : widget.labelEN,
              children: <Widget>[...undecoratedChilds]),
        ],
      ),
    );
  }
}
