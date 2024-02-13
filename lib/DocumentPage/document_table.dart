import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/DocumentPage/doc_icon.dart';
import 'package:jotrockenmitlocken/DocumentPage/document.dart';
import 'package:jotrockenmitlocken/DocumentPage/open_button.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentTable extends StatefulWidget {
  const DocumentTable({
    super.key,
    required this.colorSelected,
  });
  final ColorSeed colorSelected;
  @override
  AboutMeTableState createState() => AboutMeTableState();
}

class AboutMeTableState extends State<DocumentTable> {
  List<Document> docs = [
    Document(
      'CV_Jonas_Heinle_english.pdf',
      '~3.7MB English',
    ),
    Document(
      'CV_Jonas_Heinle_german.pdf',
      '~3.7MB German',
    ),
    Document('Bachelor_Thesis.pdf', '~33MB German')
  ];

  @override
  void initState() {
    super.initState();
  }

  double getDocumentTableWidth() {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return currentWidth * 0.9;
    } else if (currentWidth <= largeWidthBreakpoint) {
      return currentWidth * 0.6;
    } else {
      return currentWidth * 0.4;
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    // mobile version
    var tablePadding = 0.0;
    if (currentWidth <= narrowScreenWidthThreshold) {
      tablePadding = 0.9;
    } else if (currentWidth <= largeWidthBreakpoint) {
      tablePadding = 8;
    } else {
      tablePadding = 8;
    }

    return Column(children: [
      Container(
        alignment: Alignment.center,
        child: Text(
          AppLocalizations.of(context)!.documents,
          textAlign: TextAlign.center,
          style: FontHelper.getTextStyleHeadings(context),
        ),
      ),
      SizedBox(
        width: getDocumentTableWidth(),
        child: applyBoxDecoration(
            ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: docs.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: _buildListItem,
            ),
            EdgeInsets.all(tablePadding),
            0,
            8,
            4,
            widget.colorSelected.color),
      )
    ]);
  }

  Widget _buildListItem(BuildContext context, int index) {
    Document currentDocument = docs.elementAt(index);
    return Container(
        padding: const EdgeInsets.all(0),
        child: ListTile(
          leading: DocIcon(document: currentDocument),
          title: Text(
            currentDocument.title,
            style: FontHelper.getTextStyle(context),
          ),
          subtitle: Text(
            currentDocument.additionalInfo,
            overflow: TextOverflow.ellipsis,
            style: FontHelper.getTextStyle(context),
          ),
          trailing: DownloadButton(
            document: currentDocument,
          ),
        ));
  }
}
