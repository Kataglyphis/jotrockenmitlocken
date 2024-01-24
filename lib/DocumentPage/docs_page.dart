import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/DocumentPage/document_table.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/navigation_drawer_widget.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocsPage extends StatelessWidget {
  const DocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Color selectedColor = Theme.of(context).primaryColor;
        if (constraints.maxWidth > narrowScreenWidthThreshold) {
          return Column(
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
              const DocumentTable(),
              SizedBox(height: 10),
            ], //
          );
        } else {
          return Column(
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
              const DocumentTable(),
              SizedBox(height: 10),
            ],
          );
        }
      },
    );
  }
}
