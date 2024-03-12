import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file_table.dart';

class DocumentTable extends FileTable {
  const DocumentTable({super.key, required super.docs});

  @override
  State<StatefulWidget> createState() => DocumentState();
}

class DocumentState extends FileTableState {
  @override
  String getTitle() {
    return AppLocalizations.of(context)!.documents;
  }
}
