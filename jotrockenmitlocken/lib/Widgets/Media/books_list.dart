import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jotrockenmitlocken/Widgets/Media/book.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

import 'package:jotrockenmitlockenrepo/Media/data_list.dart';

class BooksList extends StatefulWidget {
  const BooksList({super.key});

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> with DataListState<Book> {
  @override
  ColorSeed getColorSeed() {
    // TODO: implement getColorSeed
    throw UnimplementedError();
  }

  @override
  String getTitle() {
    return "Books worth reading";
  }

  @override
  String getDescription() {
    return "TODO: Implement";
  }

  @override
  void onSortData(int columnIndex, bool ascending) {
    setState(() {
      Sort(columnIndex, ascending);
    });
  }

  @override
  List<double> getSpacing() {
    return [0.25, 0.25, 0.25, 0.25];
  }

  @override
  Future<List<List<dynamic>>> _loadBooksFromCSV() async {
    final rawData = await rootBundle.loadString("assets/data/Buecherliste.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    dataCategories = List<String>.from(listData.first);

    Data = listData
        .getRange(1, listData.length)
        .toList()
        .map((List e) => Book(
              title: e.elementAt(0),
              author: e.elementAt(1),
              ISBN: e.elementAt(2),
            ))
        .toList();
    return listData;
  }

  @override
  initState() {
    super.initState();
    dataFuture = _loadBooksFromCSV();
  }
}
