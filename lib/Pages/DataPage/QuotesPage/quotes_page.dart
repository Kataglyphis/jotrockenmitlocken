import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/QuotesPage/quotes_list.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlocken/l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Pages/csv_data_page.dart';

class QuotesPage extends StatelessWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  const QuotesPage({
    super.key,
    required this.appAttributes,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return CsvDataPage(
      appAttributes: appAttributes,
      footer: footer,
      child: QuotesList(
        entryRedirectText: AppLocalizations.of(context)!.entryRedirectText,
        title: AppLocalizations.of(context)!.quotations,
        description:
            "${AppLocalizations.of(context)!.quotationsDescription}\u{1F63A}",
        dataFilePath: "assets/data/Zitate.csv",
      ),
    );
  }
}
