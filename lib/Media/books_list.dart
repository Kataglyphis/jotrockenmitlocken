import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jotrockenmitlocken/AboutMe/book.dart';
import 'package:jotrockenmitlocken/Navbar/Navbar.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/navigation_drawer_widget.dart';
import 'package:jotrockenmitlocken/constants.dart';

class BooksList extends StatefulWidget {
  const BooksList({Key? key}) : super(key: key);

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  late Future<List<List<dynamic>>> _bookFuture;
  List<String> _bookCategories = [];
  late List<Book> _books;
  int _sortColumnIndexBook = 0;
  bool _isAscendingBook = true;

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
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

  @override
  initState() {
    super.initState();
    _bookFuture = _loadBooksFromCSV();
  }

  Widget buildDataTable() {
    return FutureBuilder(
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  const NavBar(),
                  buildDataTable(),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            drawer: const NavigationDrawerWidget(),
            appBar: AppBar(
              title: const Text(appName),
              backgroundColor: kPrimaryColor,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  buildDataTable(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
