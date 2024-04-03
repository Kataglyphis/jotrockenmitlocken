import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlockenrepo/Decoration/col_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/Decoration/component_group_decoration.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file_tile.dart';
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
    required this.lastModified,
    required this.fileTitle,
    required this.fileAdditionalInfo,
    required this.fileBaseDir,
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
  final String lastModified;
  final String fileTitle;
  final String fileAdditionalInfo;
  final String fileBaseDir;

  @override
  State<LandingPageEntry> createState() => LandingPageEntryState();
}

class LandingPageEntryState extends State<LandingPageEntry> {
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> undecoratedChilds = [
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
            "${widget.description}",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
      // //rowDivider,
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
        imageCaptioning: widget.imageCaptioning,
      ),
      rowDivider,
      IntrinsicWidth(
        child: FileTile(
            currentDocument: File(
                title: widget.fileTitle,
                additionalInfo: widget.fileAdditionalInfo,
                baseDir: widget.fileBaseDir)),
      ),
      rowDivider,
      Padding(
        padding: const EdgeInsets.only(right: 34.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.lastModified,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
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
