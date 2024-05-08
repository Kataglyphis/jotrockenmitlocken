import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BooksPage/book.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/data_list.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/datacell_content_strategies.dart';
import 'package:jotrockenmitlockenrepo/Pages/my_two_cents_config.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class BooksList extends DataList {
  const BooksList(
      {super.key,
      required super.dataFilePath,
      required super.title,
      required super.description,
      required this.appAttributes});
  //"Books worth reading"
  @override
  State<BooksList> createState() => _BooksListState();

  final AppAttributes appAttributes;
}

class _BooksListState extends DataListState<Book, BooksList> {
  @override
  Future<(List<Book>, List<String>)> convertRawCSVDataToFinalLayout(
      List<List<dynamic>> csvListData) async {
    List<MyTwoCentsConfig> configs = widget.appAttributes.twoCentsConfigs;
    List<String> dataCategories = List<String>.from(csvListData.first);
    List<Book> convertedCsvListData =
        csvListData.getRange(1, csvListData.length).toList().map((List e) {
      int index = configs
          .indexWhere((item) => item.mediaTitle == e.elementAt(0).toString());
      return Book(
        title: e.elementAt(0).toString(),
        author: e.elementAt(1).toString(),
        isbn: e.elementAt(2).toString(),
        comment: index != -1 ? configs[index].routingName : "",
      );
    }).toList();
    return (convertedCsvListData, dataCategories);
  }

  @override
  List<double> getSpacing() {
    return [0.2, 0.2, 0.2, 0.2];
  }

  @override
  List<DataCellContentStrategies> getDataCellContentStrategies() {
    return [
      DataCellContentStrategies.text,
      DataCellContentStrategies.text,
      DataCellContentStrategies.text,
      DataCellContentStrategies.textButton
    ];
  }
}
