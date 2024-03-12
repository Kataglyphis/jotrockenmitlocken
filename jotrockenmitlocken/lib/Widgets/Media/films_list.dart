import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jotrockenmitlockenrepo/Media/data_list.dart';
import 'package:jotrockenmitlocken/Widgets/Media/film.dart';

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
  List<double> getSpacing() {
    return [0.33, 0.33, 0.33];
  }

  @override
  void onSortData(int columnIndex, bool ascending) {
    setState(() {
      sort(columnIndex, ascending);
    });
  }

  @override
  Future<List<List<dynamic>>> loadDataFromCSV() async {
    final rawData = await rootBundle.loadString("assets/data/Filmliste.csv");
    List<List<dynamic>> csvListData =
        const CsvToListConverter().convert(rawData);

    dataCategories = List<String>.from(csvListData.first);
    listData = csvListData
        .getRange(1, listData.length)
        .toList()
        .map((List e) => Film(
              title: e.elementAt(0),
              isan: e.elementAt(1),
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
