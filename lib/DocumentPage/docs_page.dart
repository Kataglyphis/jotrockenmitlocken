import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/DocumentPage/document_table.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocsPage extends StatefulWidget {
  const DocsPage({
    super.key,
    required this.colorSelected,
  });

  final ColorSeed colorSelected;
  @override
  State<DocsPage> createState() => _DocsPageState();
}

class _DocsPageState extends State<DocsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.documents,
                    textAlign: TextAlign.center,
                    style: FontHelper.getTextStyleHeadings(context),
                  ),
                ),
                SizedBox(height: 10),
                DocumentTable(
                  colorSelected: widget.colorSelected,
                ),
                SizedBox(height: 10),
              ], //
            ));
      },
    );
  }
}
