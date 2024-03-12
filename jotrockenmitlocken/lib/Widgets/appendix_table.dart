import 'package:jotrockenmitlockenrepo/Media/Files/file_table.dart';
import 'package:flutter/material.dart';

class AppendixTable extends FileTable {
  const AppendixTable({super.key, required super.docs});

  @override
  State<StatefulWidget> createState() => DocumentState();
}

class DocumentState extends FileTableState {
  @override
  String getTitle() {
    return 'Appendix';
  }
}
