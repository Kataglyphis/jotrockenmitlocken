import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/FilmsPage/films_list.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Pages/csv_data_page.dart';

class FilmsPage extends StatelessWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  const FilmsPage({
    super.key,
    required this.appAttributes,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return CsvDataPage(
      appAttributes: appAttributes,
      footer: footer,
      child: FilmsList(
        entryRedirectText: AppLocalizations.of(context)!.entryRedirectText,
        title: AppLocalizations.of(context)!.films,
        description:
            "${AppLocalizations.of(context)!.filmsDescription}\u{1F63A}",
        dataFilePath: "assets/data/Filmliste_gesehen.csv",
      ),
    );
  }
}
