import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jotrockenmitlocken/Widgets/Media/book.dart';
import 'package:jotrockenmitlockenrepo/Media/data_list.dart';

class BooksList extends StatefulWidget {
  const BooksList({super.key});

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> with DataListState<Book> {
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
      sort(columnIndex, ascending);
    });
  }

  @override
  List<double> getSpacing() {
    return [0.25, 0.25, 0.25, 0.25];
  }

  @override
  Future<List<List<dynamic>>> loadDataFromCSV() async {
    final rawData = await rootBundle.loadString("assets/data/Buecherliste.csv");
    List<List<dynamic>> csvListData =
        const CsvToListConverter().convert(rawData);
    dataCategories = List<String>.from(csvListData.first);

    listData = csvListData
        .getRange(1, listData.length)
        .toList()
        .map((List e) => Book(
              title: e.elementAt(0),
              author: e.elementAt(1),
              isbn: e.elementAt(2),
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
