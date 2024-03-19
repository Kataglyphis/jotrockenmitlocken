import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Widgets/Media/book.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/data_list.dart';

class BooksList extends DataList {
  const BooksList(
      {super.key,
      required super.dataFilePath,
      required super.title,
      required super.description});
  // "assets/data/Buecherliste.csv"
  //"Books worth reading"
  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends DataListState<Book, BooksList> {
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
