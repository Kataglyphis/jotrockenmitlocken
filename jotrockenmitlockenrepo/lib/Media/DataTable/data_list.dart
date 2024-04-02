import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Decoration/centered_box_decoration.dart';

import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/table_data.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

class _MyDataTableSource extends DataTableSource {
  List<DataRow> dataRows;
  _MyDataTableSource(this.dataRows);

  @override
  DataRow? getRow(int index) {
    return dataRows[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataRows.length;

  @override
  int get selectedRowCount => 0;
}

abstract class DataList extends StatefulWidget {
  const DataList(
      {super.key,
      required this.dataFilePath,
      required this.title,
      required this.description});
  final String title;
  final String dataFilePath;
  final String description;
}

abstract class DataListState<T extends TableData, U extends DataList>
    extends State<U> {
  int sortColumnIndex = 0;
  bool isAscending = true;

  late Future<(List<T>, List<String>)> _rawCsvData;

  List<double> getSpacing();
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

  int _compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  List<DataRow> getDataRows(List<T> csvData, double maxWidth) {
    return csvData.map((T data) {
      return DataRow(
          cells: data
              .getCells()
              .map((entry) => DataCell(SizedBox(
                    width: (maxWidth) *
                        getSpacing()[data.getCells().indexOf(entry)],
                    child: Text(
                      entry,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  )))
              .toList());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    double dataTableWidth = (currentWidth >= largeWidthBreakpoint)
        ? currentWidth * 0.8
        : currentWidth * 0.9;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          rowDivider,
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          rowDivider,
          FutureBuilder(
              future: _rawCsvData,
              builder: (context, data) {
                if (data.hasData) {
                  List<T> csvData = data.requireData.$1;
                  List<String> dataCategories = data.requireData.$2;

                  final DataTableSource dataTableSource =
                      _MyDataTableSource(getDataRows(csvData, dataTableWidth));
                  return SizedBox(
                    width: dataTableWidth,
                    child: CenteredBoxDecoration(
                      borderRadius: 8,
                      borderWidth: 6,
                      color: Theme.of(context).colorScheme.primary,
                      child: PaginatedDataTable(
                        dataRowMaxHeight: double.infinity,
                        sortColumnIndex: sortColumnIndex,
                        sortAscending: isAscending,
                        columns: dataCategories
                            .map((String column) => DataColumn(
                                  label: Text(column),
                                  onSort: (int columnIndex, bool ascending) {
                                    setState(() {
                                      csvData.sort((data1, data2) =>
                                          _compareString(
                                              isAscending,
                                              data1.getCells()[columnIndex],
                                              data2.getCells()[columnIndex]));

                                      this.sortColumnIndex = columnIndex;
                                      this.isAscending = ascending;
                                    });
                                  },
                                ))
                            .toList(),
                        source: dataTableSource,
                      ),
                    ),
                  );
                } else if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ]);
  }
}
