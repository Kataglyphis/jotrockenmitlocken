import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/data_list.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quote.dart';

class QuotesList extends DataList {
  const QuotesList({
    super.key,
    required super.dataFilePath,
    required super.title,
    required super.description,
  });

  @override
  State<QuotesList> createState() => _QuotesListState();
}

class _QuotesListState extends DataListState<Quote, QuotesList> {
  String _formatQuote(String unformattedQuote) {
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
              content: _formatQuote(e.elementAt(1).toString()),
            ))
        .toList();
    return csvListData;
  }
}
