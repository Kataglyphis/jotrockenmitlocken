import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jotrockenmitlocken/Media/data_list.dart';
import 'package:jotrockenmitlocken/Media/film.dart';
import 'package:jotrockenmitlocken/constants.dart';

class FilmsList extends StatefulWidget {
  const FilmsList({super.key});

  @override
  State<FilmsList> createState() => _FilmsListState();
}

class _FilmsListState extends State<FilmsList> with DataListState<Film> {
  @override
  String getTitle() {
    return "Films/Series worth watching";
  }

  @override
  String getDescription() {
    return "TODO: Implement";
  }

  @override
  int getNumRowsForSimultaneousDisplay() {
    // for mobile devices we will need an larger height :)
    if (MediaQuery.of(context).size.width <= narrowScreenWidthThreshold) {
      return 3;
    } else {
      return 6;
    }
  }

  @override
  List<double> getSpacing() {
    return [0.33, 0.33, 0.33];
  }

  @override
  double getDataRowHeight() {
    // for mobile devices we will need an larger height :)
    if (MediaQuery.of(context).size.width >= largeWidthBreakpoint) {
      return 80;
    } else {
      return 120;
    }
  }

  @override
  void onSortData(int columnIndex, bool ascending) {
    setState(() {
      Sort(columnIndex, ascending);
    });
  }

  Future<List<List<dynamic>>> _loadFilmsFromCSV() async {
    final rawData = await rootBundle.loadString("assets/data/Filmliste.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    dataCategories = List<String>.from(listData.first);
    Data = listData
        .getRange(1, listData.length)
        .toList()
        .map((List e) => Film(
              e.elementAt(0),
              e.elementAt(1),
            ))
        .toList();
    return listData;
  }

  @override
  initState() {
    super.initState();
    dataFuture = _loadFilmsFromCSV();
  }
}
