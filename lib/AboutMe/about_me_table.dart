import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jotrockenmitlocken/AboutMe/film.dart';

import 'book.dart';

class AboutMeTable extends StatefulWidget {
  const AboutMeTable({Key? key}) : super(key: key);

  @override
  State<AboutMeTable> createState() => _AboutMeTableState();
}

class _AboutMeTableState extends State<AboutMeTable> {
  late Future<List<List<dynamic>>> _bookFuture;
  List<String> _bookCategories = [];
  late List<Book> _books;
  int _sortColumnIndexBook = 0;
  bool _isAscendingBook = true;

  late Future<Map<String, dynamic>> _readJson;

  late Future<List<List<dynamic>>> _filmFuture;
  List<String> _filmCategories = [];
  late List<Film> _films = [];
  int _sortColumnIndexFilm = 0;
  bool _isAscendingFilm = false;

  @override
  initState() {
    super.initState();
    this._books = [];
    _readJson = readJson();
    _bookFuture = _loadBooksFromCSV();
    _filmFuture = _loadFilmsFromCSV();
  }

  Future<List<List<dynamic>>> _loadBooksFromCSV() async {
    final _rawData =
        await rootBundle.loadString("assets/data/Buecherliste.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    _bookCategories = List<String>.from(_listData.first);

    _books = _listData
        .getRange(1, _listData.length)
        .toList()
        .map((List e) => Book(
              e.elementAt(0),
              e.elementAt(1),
              e.elementAt(2),
              e.elementAt(3),
              e.elementAt(4),
            ))
        .toList() as List<Book>;
    return _listData;
  }

  Future<List<List<dynamic>>> _loadFilmsFromCSV() async {
    final _rawData = await rootBundle.loadString("assets/data/Filmliste.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);

    _filmCategories = List<String>.from(_listData.first);
    _films = _listData
        .getRange(1, _listData.length)
        .toList()
        .map((List e) => Film(
              e.elementAt(0),
              e.elementAt(1),
              e.elementAt(2),
              e.elementAt(3).toString(),
              e.elementAt(4),
            ))
        .toList() as List<Film>;
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
      if (columnIndex == 0) {
        _books.sort((book1, book2) =>
            compareString(_isAscendingBook, book1.title, book2.title));
      } else if (columnIndex == 1) {
        _books.sort((book1, book2) =>
            compareString(_isAscendingBook, book1.author, book2.author));
      } else if (columnIndex == 2) {
        _books.sort((book1, book2) =>
            compareString(_isAscendingBook, book1.genre, book2.genre));
      } else if (columnIndex == 3) {
        _books.sort((book1, book2) =>
            compareString(_isAscendingBook, book1.read, book2.read));
      } else if (columnIndex == 4) {
        _books.sort((book1, book2) =>
            compareString(_isAscendingBook, book1.year, book2.year));
      }

      this._sortColumnIndexBook = columnIndex;
      this._isAscendingBook = ascending;
    });
  }

  void onSortFilm(int columnIndex, bool ascending) {
    setState(() {
      if (columnIndex == 0) {
        _films.sort((film1, film2) =>
            compareString(_isAscendingFilm, film1.title, film2.title));
      } else if (columnIndex == 1) {
        _films.sort((film1, film2) =>
            compareString(_isAscendingFilm, film1.genre, film2.genre));
      } else if (columnIndex == 2) {
        _films.sort((film1, film2) =>
            compareString(_isAscendingFilm, film1.director, film2.director));
      } else if (columnIndex == 3) {
        _films.sort((film1, film2) =>
            compareString(_isAscendingFilm, film1.year, film2.year));
      } else if (columnIndex == 4) {
        _films.sort((film1, film2) =>
            compareString(_isAscendingFilm, film1.watched, film2.watched));
      }

      this._sortColumnIndexFilm = columnIndex;
      this._isAscendingFilm = ascending;
    });
  }

  List<DataRow> getBookDataRows(List<Book> rowData) => rowData.map((Book book) {
        final cells = [
          book.title,
          book.author,
          book.genre,
          book.read,
          book.year
        ];
        return DataRow(
            cells: cells.map((entry) => DataCell(Text('$entry'))).toList());
      }).toList();

  List<DataColumn> getBookColumns(List<String> _columnsString) {
    return _columnsString
        .map((String column) => DataColumn(
              label: Text(column),
              onSort: onSortBook,
            ))
        .toList();
  }

  List<DataRow> getFilmDataRows(List<Film> rowData) => rowData.map((Film film) {
        final cells = [
          film.title,
          film.genre,
          film.director,
          film.year,
          film.watched,
        ];
        return DataRow(
            cells: cells.map((entry) => DataCell(Text('$entry'))).toList());
      }).toList();

  List<DataColumn> getFilmColumns(List<String> _columnsString) {
    return _columnsString
        .map((String column) => DataColumn(
              label: Text(column),
              onSort: onSortFilm,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          FutureBuilder(
              future: _readJson,
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
                if (data.hasData) {
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
                              columns: getBookColumns(_bookCategories),
                              rows: getBookDataRows(_books)),
                        ],
                      ));
                } else {
                  return Center(child: Text("${data.error}"));
                }
              }),
          FutureBuilder(
              future: _filmFuture,
              builder: (context, data) {
                if (data.hasData) {
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
                              columns: getFilmColumns(_filmCategories),
                              rows: getFilmDataRows(_films)),
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
