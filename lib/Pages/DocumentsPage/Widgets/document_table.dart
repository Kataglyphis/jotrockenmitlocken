import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Widgets/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/Widgets/doc_icon.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/Widgets/document.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/Widgets/open_button.dart';
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
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.8;
    } else {
      return currentWidth * 0.5;
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
    var colDivider = SizedBox(height: 10);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          colDivider,
          Text(
            AppLocalizations.of(context)!.documents,
            textAlign: TextAlign.center,
            style: FontHelper.getTextStyleHeadings(context),
          ),
          colDivider,
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
          ),
        ]);
  }

  Widget _buildListItem(BuildContext context, int index) {
    Document currentDocument = docs.elementAt(index);
    return Container(
        alignment: Alignment.center,
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
