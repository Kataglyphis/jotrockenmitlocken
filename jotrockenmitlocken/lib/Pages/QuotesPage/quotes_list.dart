import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jotrockenmitlockenrepo/Media/data_list.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quote.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuotesList extends StatefulWidget {
  const QuotesList({
    super.key,
  });
  @override
  State<QuotesList> createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> with DataListState<Quote> {
  @override
  String getTitle() {
    return AppLocalizations.of(context)!.quotations;
  }

  @override
  String getDescription() {
    return AppLocalizations.of(context)!.quotationsDescription;
  }

  @override
  List<double> getSpacing() {
    return [0.2, 0.65];
  }

  @override
  void onSortData(int columnIndex, bool ascending) {
    setState(() {
      sort(columnIndex, ascending);
    });
  }

  String formatQuote(String unformattedQuote) {
    return "»$unformattedQuote«";
  }

  @override
  Future<List<List<dynamic>>> loadDataFromCSV() async {
    final rawData = await rootBundle.loadString("assets/data/Zitate.csv");
    List<List<dynamic>> csvListData =
        const CsvToListConverter().convert(rawData);

    dataCategories = List<String>.from(csvListData.first);
    listData = csvListData
        .getRange(1, csvListData.length)
        .toList()
        .map((List e) => Quote(
              author: e.elementAt(0).toString(),
              content: formatQuote(e.elementAt(1).toString()),
            ))
        .toList();
    return csvListData;
  }

  @override
  initState() {
    super.initState();
    dataFuture = loadDataFromCSV();
  }
}
