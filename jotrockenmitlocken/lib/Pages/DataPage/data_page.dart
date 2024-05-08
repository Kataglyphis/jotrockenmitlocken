import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/data_page_entry.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';

import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/one_two_transition_widget.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class DataPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  const DataPage(
      {super.key, required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => DataPageState();
}

class DataPageState extends State<DataPage> {
  List<List<Widget>> _createLandingPageChildWidgets(BuildContext context) {
    List<Widget> childWidgetsLeftPage = [
      DataPageEntry(
        label: AppLocalizations.of(context)!.quotations,
        routerPath: '/quotations',
        imagePath: 'assets/images/ScreenshotVulkanPathTracing.png',
        description: AppLocalizations.of(context)!.quotationsDescription,
        lastModified: 'yesterday',
      ),
      rowDivider,
      DataPageEntry(
        label: AppLocalizations.of(context)!.films,
        routerPath: '/films',
        imagePath: 'assets/images/ScreenshotVulkanPathTracing.png',
        description: AppLocalizations.of(context)!.filmsDescription,
        lastModified: 'yesterday',
      ),
      rowDivider,
    ];
    List<Widget> childWidgetsRightPage = [
      DataPageEntry(
        label: AppLocalizations.of(context)!.books,
        routerPath: '/books',
        imagePath: 'assets/images/ScreenshotVulkanPathTracing.png',
        description: AppLocalizations.of(context)!.booksDescription,
        lastModified: 'yesterday',
      ),
    ];

    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  @override
  Widget build(BuildContext context) {
    var homePagesLeftRight = _createLandingPageChildWidgets(context);

    return OneTwoTransitionPage(
        childWidgetsLeftPage: homePagesLeftRight[0],
        childWidgetsRightPage: homePagesLeftRight[1],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
        railAnimation: widget.appAttributes.railAnimation);
  }
}
