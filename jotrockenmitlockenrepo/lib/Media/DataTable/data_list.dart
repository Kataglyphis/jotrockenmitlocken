import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import 'package:jotrockenmitlockenrepo/Media/DataTable/datacell_content_strategies.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/jotrockenmitlocken_table.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/table_data.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

abstract class DataList extends StatefulWidget {
  DataList(
      {super.key,
      required this.dataFilePath,
      required this.title,
      required this.description,
      this.sortColumnIndex = 0,
      this.sortOnLoaded = false,
      this.isAscending = false});
  final String title;
  final String dataFilePath;
  final String description;
  bool sortOnLoaded;
  int sortColumnIndex;
  bool isAscending;
}

abstract class DataListState<T extends TableData, U extends DataList>
    extends State<U> {
  late Future<(List<T>, List<String>)> _rawCsvData;

  List<double> getSpacing();
  List<DataCellContentStrategies> getDataCellContentStrategies();
  Future<(List<T>, List<String>)> convertRawCSVDataToFinalLayout(
      List<List<dynamic>> csvListData);

  @override
  void initState() {
    super.initState();
    _rawCsvData = _loadDataFromCSV();
  }

  Future<(List<T>, List<String>)> _loadDataFromCSV() async {
    final rawData = await rootBundle.loadString(widget.dataFilePath);
    List<List<dynamic>> csvListData =
        const CsvToListConverter().convert(rawData);
    Future<(List<T>, List<String>)> finalData =
        convertRawCSVDataToFinalLayout(csvListData);
    return finalData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _rawCsvData,
        builder: (context, data) {
          if (data.hasData) {
            List<T> csvData = data.requireData.$1;
            List<String> dataCategories = data.requireData.$2;

            return JotrockenmitlockenTable(
              dataCategories: dataCategories,
              data: csvData,
              title: widget.title,
              description: widget.description,
              sortColumnIndex: widget.sortColumnIndex,
              isAscending: widget.isAscending,
              sortOnLoaded: widget.sortOnLoaded,
              spacing: getSpacing(),
              dataCellContentStrategies: getDataCellContentStrategies(),
            );
          } else if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
