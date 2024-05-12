import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DataPage/BooksPage/book.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/data_list.dart';
import 'package:jotrockenmitlockenrepo/Media/DataTable/datacell_content_strategies.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class BlockEntryList extends DataList {
  BlockEntryList({
    super.key,
    required super.data,
    required super.dataCategories,
    required super.title,
    required super.description,
    // all entries with a critic should be displayed in the very beginning :)
    super.sortColumnIndex = 3,
    super.sortOnLoaded = true,
    required this.appAttributes,
  });
  //"Books worth reading"
  @override
  State<BlockEntryList> createState() => _BlockEntryListState();

  final AppAttributes appAttributes;
}

class _BlockEntryListState extends DataListState<Book, BlockEntryList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  List<double> getSpacing() {
    return [0.3, 0.3, 0.3];
  }

  @override
  List<DataCellContentStrategies> getDataCellContentStrategies() {
    return [
      DataCellContentStrategies.text,
      DataCellContentStrategies.text,
      DataCellContentStrategies.textButton
    ];
  }
}
