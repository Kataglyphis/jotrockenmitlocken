import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/data_list.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quote.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuotesList extends DataList {
  const QuotesList({
    super.key,
    required super.dataFilePath,
  });

  @override
  State<QuotesList> createState() => _QuotesListState();
}

class _QuotesListState extends DataListState<Quote, QuotesList> {
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

  String formatQuote(String unformattedQuote) {
    return "»$unformattedQuote«";
  }

  @override
  Future<List<List<dynamic>>> convertRawCSVDataToFinalLayout(
      List<List<dynamic>> csvListData) async {
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
}
