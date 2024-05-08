import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BooksPage/book.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/data_list.dart';

class BooksList extends DataList {
  const BooksList(
      {super.key,
      required super.dataFilePath,
      required super.title,
      required super.description});
  //"Books worth reading"
  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends DataListState<Book, BooksList> {
  @override
  Future<(List<Book>, List<String>)> convertRawCSVDataToFinalLayout(
      List<List<dynamic>> csvListData) async {
    List<String> dataCategories = List<String>.from(csvListData.first);
    List<Book> convertedCsvListData = csvListData
        .getRange(1, csvListData.length)
        .toList()
        .map((List e) => Book(
              title: e.elementAt(0).toString(),
              author: e.elementAt(1).toString(),
              isbn: e.elementAt(2).toString(),
            ))
        .toList();
    return (convertedCsvListData, dataCategories);
  }

  @override
  List<double> getSpacing() {
    return [0.25, 0.25, 0.25];
  }
}
