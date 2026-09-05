import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:anthology/Decoration/row_divider.dart';
import 'package:anthology/Pages/data_page_entry.dart';

import 'package:anthology/Pages/Footer/footer.dart';
import 'package:anthology/Layout/ResponsiveDesign/one_two_transition_widget.dart';
import 'package:anthology/app_attributes.dart';

class DataPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  const DataPage({
    super.key,
    required this.appAttributes,
    required this.footer,
  });

  @override
  State<StatefulWidget> createState() => DataPageState();
}

class DataPageState extends State<DataPage> {
  List<List<Widget>> _createLandingPageChildWidgets(BuildContext context) {
    final sqliteTestLabel =
        (Localizations.localeOf(context) == const Locale('de'))
        ? 'SQLite Self-Test'
        : 'SQLite self test';
    final sqliteTestDescription =
        (Localizations.localeOf(context) == const Locale('de'))
        ? 'Prüft sqlite3 im Browser (WASM) mit einer Test-Query.'
        : 'Checks sqlite3 in the browser (WASM) with a test query.';

    List<Widget> childWidgetsLeftPage = [
      DataPageEntry(
        label: AppLocalizations.of(context)!.quotations,
        routerPath: '/quotations',
        imagePath: 'assets/images/Pages/Data/Quotes_cover.jpg',
        description: AppLocalizations.of(context)!.quotationsDescription,
        lastModified: 'babbeln',
        followLabel: AppLocalizations.of(context)!.follow,
      ),
      rowDivider,
      DataPageEntry(
        label: AppLocalizations.of(context)!.films,
        routerPath: '/films',
        imagePath: 'assets/images/Pages/Data/Film_cover.jpg',
        description: AppLocalizations.of(context)!.filmsDescription,
        lastModified: 'glotze',
        followLabel: AppLocalizations.of(context)!.follow,
      ),
      rowDivider,
      DataPageEntry(
        label: sqliteTestLabel,
        routerPath: '/sqliteTest',
        imagePath: 'assets/images/Pages/Data/Book_cover.jpg',
        description: sqliteTestDescription,
        lastModified: 'sqlite3',
        followLabel: AppLocalizations.of(context)!.follow,
      ),
      rowDivider,
    ];
    List<Widget> childWidgetsRightPage = [
      DataPageEntry(
        label: AppLocalizations.of(context)!.books,
        routerPath: '/books',
        imagePath: 'assets/images/Pages/Data/Book_cover.jpg',
        description: AppLocalizations.of(context)!.booksDescription,
        lastModified: '.._..',
        followLabel: AppLocalizations.of(context)!.follow,
      ),
      rowDivider,
      DataPageEntry(
        label: AppLocalizations.of(context)!.games,
        routerPath: '/games',
        imagePath: 'assets/images/Pages/Data/Spiele_cover.jpg',
        description: AppLocalizations.of(context)!.gamesDescription,
        lastModified: 'Go rust',
        followLabel: AppLocalizations.of(context)!.follow,
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
      appAttributes: widget.appAttributes,
      footer: widget.footer,
      showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
      showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout,
      railAnimation: widget.appAttributes.railAnimation,
    );
  }
}
