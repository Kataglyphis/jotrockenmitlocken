import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/Media/data.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/navigation_drawer_widget.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/font_helper.dart';

class MyDataTableSource extends DataTableSource {
  List<DataRow> dataRows;
  MyDataTableSource(this.dataRows);

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

abstract mixin class DataListState<T extends Data> {
  late Future<List<List<dynamic>>> dataFuture;
  List<String> dataCategories = [];
  late List<T> Data;
  int sortColumnIndex = 0;
  bool isAscending = true;

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  void Sort(int columnIndex, bool ascending) {
    Data.sort((data1, data2) => compareString(isAscending,
        data1.getCells()[columnIndex], data2.getCells()[columnIndex]));

    this.sortColumnIndex = columnIndex;
    this.isAscending = ascending;
  }

  // other classes will have to override these two methods
  void onSortData(int columnIndex, bool ascending);
  Future<List<List<dynamic>>> _loadDataFromCSV();
  String getTitle();
  // every data list gets an individual spacing
  List<double> getSpacing();
  // this sucks since it should dynamically adjust
  double getDataRowHeight();
  // how many rows should me displayed
  int getNumRowsForSimultaneousDisplay();

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

  Widget buildDataTable() {
    return FutureBuilder(
        future: dataFuture,
        builder: (context, data) {
          Color selectedColor = Theme.of(context).primaryColor;
          ThemeData lightTheme = ThemeData(
            colorSchemeSeed: selectedColor,
            brightness: Brightness.light,
          );
          ThemeData darkTheme = ThemeData(
            colorSchemeSeed: selectedColor,
            brightness: Brightness.dark,
          );
          if (data.hasData) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double currentWidth = constraints.maxWidth;
                double dataTableWidth = (currentWidth >= largeWidthBreakpoint)
                    ? currentWidth * 0.6
                    : currentWidth * 0.9;
                final DataTableSource data =
                    MyDataTableSource(getDataRows(Data, dataTableWidth * 0.9));
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        getTitle(),
                        textAlign: TextAlign.center,
                        style: FontHelper.getTextStyleHeadings(context),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: dataTableWidth,
                      child: applyBoxDecoration(
                          PaginatedDataTable(
                            dataRowHeight: getDataRowHeight(),
                            sortColumnIndex: sortColumnIndex,
                            sortAscending: isAscending,
                            columns: getDataColumns(dataCategories),
                            rowsPerPage: getNumRowsForSimultaneousDisplay(),
                            source: data,
                          ),
                          const EdgeInsets.all(0),
                          0,
                          8,
                          6,
                          selectedColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Color selectedColor = Theme.of(context).primaryColor;
        if (constraints.maxWidth > narrowScreenWidthThreshold) {
          return Scaffold(
            body: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  buildDataTable(),
                ]),
          );
        } else {
          return Scaffold(
            drawer: const NavigationDrawerWidget(),
            appBar: AppBar(
              title: const Text(appName),
              backgroundColor: selectedColor,
              centerTitle: true,
            ),
            body: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  buildDataTable(),
                ]),
          );
        }
      },
    );
  }
}
