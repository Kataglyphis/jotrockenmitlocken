import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/data_list.dart';
import 'package:jotrockenmitlocken/Widgets/Media/film.dart';

class FilmsList extends DataList {
  const FilmsList(
      {super.key,
      required super.dataFilePath,
      required super.title,
      required super.description});
  // "assets/data/Filmliste.csv"
  // "Films/Series worth watching"
  @override
  State<FilmsList> createState() => _FilmsListState();
}

class _FilmsListState extends DataListState<Film, FilmsList> {
  @override
  Future<(List<Film>, List<String>)> convertRawCSVDataToFinalLayout(
      List<List<dynamic>> csvListData) async {
    List<String> dataCategories = List<String>.from(csvListData.first);
    List<Film> convertedCsvListData = csvListData
        .getRange(1, csvListData.length)
        .toList()
        .map((List e) => Film(
              title: e.elementAt(0),
              isan: e.elementAt(1),
            ))
        .toList();
    return (convertedCsvListData, dataCategories);
  }

  @override
  List<double> getSpacing() {
    return [0.33, 0.33, 0.33];
  }
}
