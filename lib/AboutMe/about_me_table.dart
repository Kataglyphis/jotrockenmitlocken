import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class AboutMeTable extends StatefulWidget {
  const AboutMeTable({Key? key}) : super(key: key);

  @override
  State<AboutMeTable> createState() => _AboutMeTableState();
}

class _AboutMeTableState extends State<AboutMeTable> {
  //List<DataRow> rows_book = [];
  late Future<List<List<dynamic>>> _bookFuture;
  List<String> _book_columns = [];
  List<DataRow> _rows_books = [];
  late Future<List<List<dynamic>>> _filmFuture;
  int _sortColumnIndexBook = 0;
  bool _isAscendingBook = false;
  //List<DataRow> rows_film = [];
  int _sortColumnIndexFilm = 0;
  bool _isAscendingFilm = false;

  @override
  initState() {
    super.initState();
    _bookFuture = _loadCSV("assets/data/Buecherliste.csv");
    _filmFuture = _loadCSV("assets/data/Filmliste.csv");
  }

  Future<List<List<dynamic>>> _loadCSV(String csvFile) async {
    final _rawData = await rootBundle.loadString(csvFile);
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    return _listData;
  }

  // Fetch content from the json file
  Future<Map<String, dynamic>> readJson() async {
    final jsonData = await rootBundle.loadString('assets/data/aboutme.json');
    final Map<String, dynamic> list = json.decode(jsonData);
    return list;
  }

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  void onSortBook(int columnIndex, bool ascending) {
    setState(() {
      this._sortColumnIndexBook = columnIndex;
      this._isAscendingBook = ascending;
      _rows_books.sort((dataRow1, dataRow2) => compareString(
          _isAscendingBook,
          dataRow1.cells[_sortColumnIndexBook].child.toString(),
          dataRow2.cells[_sortColumnIndexBook].child.toString()));
    });
  }

  void onSortFilm(int columnIndex, bool ascending) {
    setState(() {
      this._sortColumnIndexFilm = columnIndex;
      this._isAscendingFilm = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          FutureBuilder(
              future: readJson(),
              builder: (context, data) {
                if (data.hasData) {
                  var items = data.data as Map;
                  var keys = items.keys.toList();
                  var values = items.entries.toList();

                  return Container(
                    height: 400,
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth / 4,
                                      height: 50,
                                      child: Text(keys[index] + " : ",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth / 2,
                                      height: 50,
                                      child: Text(
                                        items[keys[index]],
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ], //
                            ),
                          );
                        }),
                  );
                } else if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          FutureBuilder(
              future: _bookFuture, //_loadCSV("assets/data/Buecherliste.csv"),
              builder: (context, data) {
                debugPrint('Build future');
                if (data.connectionState == ConnectionState.done) {
                  if (data.hasData) {
                    var items = data.data as List<List>;
                    // var keys = items.keys.toList();
                    // var values = items.entries.toList();
                    List<String> columns_string =
                        List<String>.from(items.first);
                    final book_columns = columns_string
                        .map((String column) => DataColumn(
                              label: Text(column),
                              onSort: onSortBook,
                            ))
                        .toList();

                    var row_strings = items.getRange(1, items.length);
                    _rows_books = row_strings
                        .map((List row) => DataRow(
                              cells: row
                                  .map((entry) => DataCell(Text('$entry')))
                                  .toList(),
                            ))
                        .toList();

                    return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Text(
                              "Book List",
                              style: TextStyle(fontSize: 32),
                            ),
                            DataTable(
                                sortColumnIndex: _sortColumnIndexBook,
                                sortAscending: _isAscendingBook,
                                columns: book_columns,
                                rows: _rows_books),
                          ],
                        ));
                  } else {
                    return Center(child: Text("${data.error}"));
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          FutureBuilder(
              future: _filmFuture,
              builder: (context, data) {
                if (data.hasData) {
                  var items = data.data as List<List>;
                  // var keys = items.keys.toList();
                  // var values = items.entries.toList();
                  List<String> columns_string = List<String>.from(items.first);
                  final columns = columns_string
                      .map((String column) => DataColumn(
                            label: Text(column),
                            onSort: onSortFilm,
                          ))
                      .toList();

                  var row_strings = items.getRange(1, items.length);
                  var rows_film = row_strings
                      .map((List row) => DataRow(
                            cells: row
                                .map((entry) => DataCell(Text('$entry')))
                                .toList(),
                          ))
                      .toList();
                  rows_film.sort((dataRow1, dataRow2) => compareString(
                      _isAscendingFilm,
                      dataRow1.cells[_sortColumnIndexFilm].child.toString(),
                      dataRow2.cells[_sortColumnIndexFilm].child.toString()));
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Text(
                            "Film List",
                            style: TextStyle(fontSize: 32),
                          ),
                          DataTable(
                              sortColumnIndex: _sortColumnIndexFilm,
                              sortAscending: _isAscendingFilm,
                              columns: columns,
                              rows: rows_film),
                        ],
                      ));
                } else if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      );
    });
  }
}
