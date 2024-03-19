import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Widgets/Media/book.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/data_list.dart';

class BooksList extends DataList {
  const BooksList({super.key, required super.dataFilePath});
  // "assets/data/Buecherliste.csv"
  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends DataListState<Book, BooksList> {
  @override
  String getTitle() {
    return "Books worth reading";
  }

  @override
  String getDescription() {
    return "TODO: Implement";
  }

  @override
  List<double> getSpacing() {
    return [0.25, 0.25, 0.25, 0.25];
  }

  @override
  Future<List<List<dynamic>>> convertRawCSVDataToFinalLayout(
      List<List<dynamic>> csvListData) async {
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
}
