
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/constants.dart';

class MarkdownFilePage extends StatefulWidget {
  const MarkdownFilePage({super.key});

  @override
  _MarkdownFilePage createState() => _MarkdownFilePage();
}

class _MarkdownFilePage extends State<MarkdownFilePage> {
  String _markupContent = "";

  @override
  void initState() {
    super.initState();
    loadMarkupFile();
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
    String filePath = 'assets/documents/README.md';

    try {
      // Read file conten
      return await rootBundle.loadString(filePath);
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
      return currentWidth * 0.6;
    } else {
      return currentWidth * 0.4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.documents,
                    textAlign: TextAlign.center,
                    style: FontHelper.getTextStyleHeadings(context),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: getMarkdownPageWidth(),
                    child: MarkdownBody(data: _markupContent)),
                const SizedBox(height: 10),
              ], //
            ));
      },
    );
  }
}
