import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter/services.dart' show rootBundle;
import 'package:jotrockenmitlocken/constants.dart';

class MarkdownFilePage extends StatefulWidget {
  MarkdownFilePage(
      {super.key, required this.filePathDe, required this.filePathEn});
  String filePathDe;
  String filePathEn;

  @override
  _MarkdownFilePage createState() => _MarkdownFilePage();
}

class _MarkdownFilePage extends State<MarkdownFilePage> {
  String _markupContent = '''''';
  @override
  void initState() {
    super.initState();
  }

  Future<void> loadMarkupFile() async {
    // Load markup file
    String markupContent = await _readMarkupFile();
    setState(() {
      _markupContent = markupContent;
    });
  }

  Future<String> _readMarkupFile() async {
    // Path to the markup file
    assert(widget.filePathDe != '' || widget.filePathEn != '',
        'You must provide at least one correct file path!');
    try {
      // Read file content
      if (Localizations.localeOf(context) == const Locale('de') &&
          widget.filePathDe != '') {
        return await rootBundle.loadString(widget.filePathDe);
      } else if (Localizations.localeOf(context) == const Locale('de') &&
          widget.filePathEn != '') {
        return await rootBundle.loadString(widget.filePathEn);
      } else if (Localizations.localeOf(context) == const Locale('en') &&
          widget.filePathEn != '') {
        return await rootBundle.loadString(widget.filePathEn);
      } else if (Localizations.localeOf(context) == const Locale('en') &&
          widget.filePathDe != '') {
        return await rootBundle.loadString(widget.filePathDe);
      } else if (widget.filePathDe != '') {
        return await rootBundle.loadString(widget.filePathDe);
      } else {
        return await rootBundle.loadString(widget.filePathEn);
      }
    } catch (e) {
      print("Error reading file: $e");
      return '';
    }
  }

  double getMarkdownPageWidth() {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return currentWidth * 0.9;
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.7;
    } else {
      return currentWidth * 0.6;
    }
  }

  @override
  Widget build(BuildContext context) {
    loadMarkupFile();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 10),
        SizedBox(
            width: getMarkdownPageWidth(),
            child: Center(
                child: MarkdownBody(
              selectable: true,
              data: _markupContent,
              styleSheet: MarkdownStyleSheet(
                  h1: TextStyle(fontWeight: FontWeight.bold),
                  h1Align: WrapAlignment.end,
                  //h1Padding: EdgeInsets.fromViewPadding(padding, devicePixelRatio),
                  h2Align: WrapAlignment.center),
              styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
              imageDirectory: 'assets/images/',
              builders: {
                'latex': LatexElementBuilder(
                  textStyle: const TextStyle(color: Colors.blue),
                ),
              },
              extensionSet: md.ExtensionSet(
                <md.BlockSyntax>[
                  LatexBlockSyntax(),
                  ...md.ExtensionSet.gitHubWeb.blockSyntaxes,
                ],
                <md.InlineSyntax>[
                  md.EmojiSyntax(),
                  LatexInlineSyntax(),
                  ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
                ],
              ),
            ))),
        const SizedBox(height: 10),
      ], //
    );
  }
}
