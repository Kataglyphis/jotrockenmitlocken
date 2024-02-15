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
  final text = '''
This is inline latex: \$f(x) = \\sum_{i=0}^{n} \\frac{a_i}{1+x}\$

This is block level latex:

\$
c = \\pm\\sqrt{a^2 + b^2}
\$

This is inline latex with displayMode: \$\$f(x) = \\sum_{i=0}^{n} \\frac{a_i}{1+x}\$\$

To calculate the area of an equilateral triangle using trigonometric functions, one can consider using the length of the side and the height. The relationship between the height and the side length of an equilateral triangle is:

\\[ \\text{Height} = \\frac{\\sqrt{3}}{2} \\times \\text{Side Length} \\]

因此，边长为 9 的正三角形的面积为：

\\[ \\text{面积} = \\frac{1}{2} \\times \\text{底} \\times \\text{高} = \\frac{1}{2} \\times 9 \\times \\frac{\\sqrt{3}}{2} \\times 9 = \\frac{81\\sqrt{3}}{4} \\]

所以正三角形的面积为 \\( \\frac{81\\sqrt{3}}{4} \\)。

''';
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
      children: <Widget>[
        const SizedBox(height: 10),
        SizedBox(
            width: getMarkdownPageWidth(),
            child: Center(
                child: MarkdownBody(
              data: _markupContent,
              builders: {
                'latex': LatexElementBuilder(
                  textStyle: const TextStyle(color: Colors.blue),
                ),
              },
              extensionSet: md.ExtensionSet(
                [LatexBlockSyntax()],
                [LatexInlineSyntax()],
              ),
            ))),
        const SizedBox(height: 10),
      ], //
    );
  }
}
