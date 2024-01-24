import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jotrockenmitlocken/Media/data_list.dart';
import 'package:jotrockenmitlocken/Media/quote.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuotesList extends StatefulWidget {
  const QuotesList({super.key});

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
    return [0.3, 0.7];
  }

  @override
  int getNumRowsForSimultaneousDisplay() {
    // for mobile devices we will need an larger height :)
    if (MediaQuery.of(context).size.width <= narrowScreenWidthThreshold) {
      return 10;
    } else {
      return 12;
    }
  }

  @override
  double getDataRowHeight() {
    // for mobile devices we will need an larger height :)
    if (MediaQuery.of(context).size.width <= narrowScreenWidthThreshold) {
      return 140;
    } else {
      return 80;
    }
  }

  @override
  void onSortData(int columnIndex, bool ascending) {
    setState(() {
      Sort(columnIndex, ascending);
    });
  }

  String formatQuote(String unformattedQuote) {
    return "»$unformattedQuote«";
  }

  Future<List<List<dynamic>>> _loadFilmsFromCSV() async {
    final rawData = await rootBundle.loadString("assets/data/Zitate.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    dataCategories = List<String>.from(listData.first);
    Data = listData
        .getRange(1, listData.length)
        .toList()
        .map((List e) => Quote(
              e.elementAt(0).toString(),
              formatQuote(e.elementAt(1).toString()),
            ))
        .toList();
    return listData;
  }

  @override
  initState() {
    super.initState();
    dataFuture = _loadFilmsFromCSV();
  }
}
