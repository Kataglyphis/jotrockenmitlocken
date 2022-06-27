import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jotrockenmitlocken/AboutMe/film.dart';
import 'package:jotrockenmitlocken/Navbar/Navbar.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/navigation_drawer_widget.dart';
import 'package:jotrockenmitlocken/constants.dart';

class FilmsList extends StatefulWidget {
  const FilmsList({Key? key}) : super(key: key);

  @override
  State<FilmsList> createState() => _FilmsListState();
}

class _FilmsListState extends State<FilmsList> {
  late Future<List<List<dynamic>>> _filmFuture;
  List<String> _filmCategories = [];
  late List<Film> _films = [];
  int _sortColumnIndexFilm = 0;
  bool _isAscendingFilm = false;

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
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

  @override
  initState() {
    super.initState();
    _filmFuture = _loadFilmsFromCSV();
  }

  Widget buildDataTable() {
    return FutureBuilder(
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
