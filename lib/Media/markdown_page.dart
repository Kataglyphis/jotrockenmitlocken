import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
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
  String _markupContent = "";

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
    } else if (currentWidth <= largeWidthBreakpoint) {
      return currentWidth * 0.8;
    } else {
      return currentWidth * 0.8;
    }
  }

  @override
  Widget build(BuildContext context) {
    loadMarkupFile();
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        SizedBox(
            width: getMarkdownPageWidth(),
            child: Center(child: MarkdownBody(data: _markupContent))),
        const SizedBox(height: 10),
      ], //
    );
  }
}
