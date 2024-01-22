import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/DocumentPage/document_table.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/navigation_drawer_widget.dart';
import 'package:jotrockenmitlocken/constants.dart';

class DocsPage extends StatelessWidget {
  const DocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Color selectedColor = Theme.of(context).primaryColor;
        if (constraints.maxWidth > narrowScreenWidthThreshold) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: getpagesSpacingToTop(context)),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Documents',
                    textAlign: TextAlign.center,
                    style: getTextStyleHeadings(context),
                  ),
                ),
                SizedBox(height: getpagesSpacingToTop(context)),
                const DocumentTable(),
                SizedBox(height: getpagesSpacingToTop(context)),
              ], //
            ),
          );
        } else {
          return Scaffold(
            drawer: const NavigationDrawerWidget(),
            appBar: AppBar(
              title: const Text(appName),
              backgroundColor: selectedColor,
              centerTitle: true,
            ),
            body: Column(
              children: <Widget>[
                SizedBox(height: getpagesSpacingToTop(context)),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Documents',
                    textAlign: TextAlign.center,
                    style: getTextStyleHeadings(context),
                  ),
                ),
                SizedBox(height: getpagesSpacingToTop(context)),
                const DocumentTable(),
                SizedBox(height: getpagesSpacingToTop(context)),
              ],
            ),
          );
        }
      },
    );
  }
}
