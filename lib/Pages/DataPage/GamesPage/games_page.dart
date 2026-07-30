import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/GamesPage/games_list.dart';
import 'package:jotrockenmitlocken/blog_dependent_app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Pages/csv_data_page.dart';

class GamesPage extends StatelessWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  final BlogDependentAppAttributes blogDependentAppAttributes;
  const GamesPage({
    super.key,
    required this.appAttributes,
    required this.footer,
    required this.blogDependentAppAttributes,
  });

  @override
  Widget build(BuildContext context) {
    return CsvDataPage(
      appAttributes: appAttributes,
      footer: footer,
      child: GamesList(
        blogDependentAppAttributes: blogDependentAppAttributes,
        entryRedirectText: AppLocalizations.of(context)!.entryRedirectText,
        appAttributes: appAttributes,
        title: AppLocalizations.of(context)!.games,
        description:
            "${AppLocalizations.of(context)!.gamesDescription}\u{1F63A}",
        dataFilePath: "assets/data/Spiele.csv",
      ),
    );
  }
}
