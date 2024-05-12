import 'package:flutter/material.dart';

import 'package:jotrockenmitlockenrepo/Media/DataTable/jotrockenmitlocken_table.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/jotrockenmitlocken_table_info_provider.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/table_data.dart';
import 'dart:developer';

abstract class DataList<T extends TableData> extends StatefulWidget {
  DataList(
      {super.key,
      required this.title,
      required this.description,
      required this.data,
      required this.dataCategories,
      this.sortColumnIndex = 0,
      this.sortOnLoaded = false,
      this.isAscending = false});
  List<T> data;
  List<String> dataCategories;
  final String title;
  final String description;
  bool sortOnLoaded;
  int sortColumnIndex;
  bool isAscending;
}

abstract class DataListState<T extends TableData, U extends DataList>
    extends State<U> with JotrockenmitlockenTableInfoProvider {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return JotrockenmitlockenTable(
      dataCategories: widget.dataCategories,
      data: widget.data,
      title: widget.title,
      description: widget.description,
      sortColumnIndex: widget.sortColumnIndex,
      isAscending: widget.isAscending,
      sortOnLoaded: widget.sortOnLoaded,
      spacing: getSpacing(),
      dataCellContentStrategies: getDataCellContentStrategies(),
    );
  }
}
