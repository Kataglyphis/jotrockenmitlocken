import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file_table.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class DocumentPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  DocumentPage({required this.appAttributes, required this.footer});

  @override
  State<StatefulWidget> createState() => DocumentPageState();
}

class DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    List<File> docs = [
      File(
        baseDir: 'assets/documents/',
        title: 'CV_Jonas_Heinle_english.pdf',
        additionalInfo: '~3.7MB English',
      ),
      File(
        baseDir: 'assets/documents/',
        title: 'CV_Jonas_Heinle_german.pdf',
        additionalInfo: '~3.7MB German',
      ),
      File(
          baseDir: 'assets/documents/',
          title: 'Bachelor_Thesis.pdf',
          additionalInfo: '~33MB German')
    ];
    return SinglePage(
        children: [
          FileTable(
            docs: docs,
            title: AppLocalizations.of(context)!.documents,
          )
        ],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
