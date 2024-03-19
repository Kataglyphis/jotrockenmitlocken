import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/data.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:flutter/services.dart';

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
  const DataList({super.key, required this.dataFilePath});
  final String dataFilePath;
}

abstract class DataListState<T extends Data, U extends DataList>
    extends State<U> {
  List<String> dataCategories = [];
  late List<T> listData;
  int sortColumnIndex = 0;
  bool isAscending = true;

  String getTitle();
  String getDescription();
  // every data list gets an individual spacing
  List<double> getSpacing();

  Future<List<List<dynamic>>> _loadDataFromCSV() async {
    final rawData = await rootBundle.loadString(widget.dataFilePath);
    List<List<dynamic>> csvListData =
        const CsvToListConverter().convert(rawData);
    List<List<dynamic>> finalData =
        await convertRawCSVDataToFinalLayout(csvListData);
    return finalData;
  }

  Future<List<List<dynamic>>> convertRawCSVDataToFinalLayout(
      List<List<dynamic>> csvListData);

  int _compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  void _sort(int columnIndex, bool ascending) {
    listData.sort((data1, data2) => _compareString(isAscending,
        data1.getCells()[columnIndex], data2.getCells()[columnIndex]));

    this.sortColumnIndex = columnIndex;
    this.isAscending = ascending;
  }

  // other classes will have to override these two methods
  void onSortData(int columnIndex, bool ascending) {
    setState(() {
      _sort(columnIndex, ascending);
    });
  }

  List<DataRow> getDataRows(List<T> rowData, double maxWidth) =>
      rowData.map((T data) {
        List<double> spacings = getSpacing();
        final cells = data.getCells();
        return DataRow(
            cells: cells
                .map((entry) => DataCell(SizedBox(
                      width: (maxWidth) * spacings[cells.indexOf(entry)],
                      child: Text(
                        entry,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    )))
                .toList());
      }).toList();

  List<DataColumn> getDataColumns(List<String> columnsString) {
    return columnsString
        .map((String column) => DataColumn(
              label: Text(column),
              onSort: onSortData,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadDataFromCSV(),
        builder: (context, data) {
          if (data.hasData) {
            double currentWidth = MediaQuery.of(context).size.width;
            double dataTableWidth = (currentWidth >= largeWidthBreakpoint)
                ? currentWidth * 0.8
                : currentWidth * 0.9;
            final DataTableSource data =
                _MyDataTableSource(getDataRows(listData, dataTableWidth));
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    getTitle(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  rowDivider,
                  Text(
                    "${getDescription()} \u{1F63A}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  rowDivider,
                  SizedBox(
                    width: dataTableWidth,
                    child: applyBoxDecoration(
                        child: PaginatedDataTable(
                          dataRowMaxHeight: double.infinity,
                          sortColumnIndex: sortColumnIndex,
                          sortAscending: isAscending,
                          columns: getDataColumns(dataCategories),
                          source: data,
                        ),
                        borderRadius: 8,
                        borderWidth: 6,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ]);
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
