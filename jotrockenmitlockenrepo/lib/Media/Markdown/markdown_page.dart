import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/ElementBuilder/centered_image_builder.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/ElementBuilder/code_element_builder.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/ElementBuilder/latex_element_builder.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/ElementBuilder/latex_inline_syntax.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/ElementBuilder/table_element_builder.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/ElementBuilder/centered_head_builder.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter/services.dart' show rootBundle;
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'dart:developer' as developer;

class MarkdownFilePage extends StatefulWidget {
  const MarkdownFilePage(
      {super.key,
      required this.currentLocale,
      required this.filePathDe,
      required this.filePathEn,
      this.imageDirectory = 'assets/images/',
      required this.useLightMode});

  final Locale currentLocale;
  final String filePathDe;
  final String filePathEn;
  final String imageDirectory;
  final bool useLightMode;

  @override
  MarkdownFilePageState createState() => MarkdownFilePageState();
}

class MarkdownFilePageState extends State<MarkdownFilePage> {
  late Future<String> _markupFileContent;
  @override
  void initState() {
    super.initState();
    _markupFileContent = _readMarkupFile();
  }

  Future<String> _readMarkupFile() async {
    // Path to the markup file
    assert(widget.filePathDe != '' || widget.filePathEn != '',
        'You must provide at least one correct file path!');
    try {
      // Read file content
      if (widget.currentLocale == const Locale('de') &&
          widget.filePathDe != '') {
        return await rootBundle.loadString(widget.filePathDe);
      } else if (widget.currentLocale == const Locale('de') &&
          widget.filePathEn != '') {
        return await rootBundle.loadString(widget.filePathEn);
      } else if (widget.currentLocale == const Locale('en') &&
          widget.filePathEn != '') {
        return await rootBundle.loadString(widget.filePathEn);
      } else if (widget.currentLocale == const Locale('en') &&
          widget.filePathDe != '') {
        return await rootBundle.loadString(widget.filePathDe);
      } else if (widget.filePathDe != '') {
        return await rootBundle.loadString(widget.filePathDe);
      } else {
        return await rootBundle.loadString(widget.filePathEn);
      }
    } catch (e) {
      developer.log("Error reading file: $e");
      return '';
    }
  }

  double getMarkdownPageWidth() {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return currentWidth * 0.9;
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.9;
    } else {
      return currentWidth * 0.7;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        rowDivider,
        FutureBuilder(
          future: _markupFileContent,
          builder: (context, data) {
            if (data.hasData) {
              return SizedBox(
                  width: getMarkdownPageWidth(),
                  child: Center(
                      child: MarkdownBody(
                    // shrinkWrap: false,
                    // fitContent: false,
                    selectable: true,
                    data: data.requireData,
                    styleSheet: MarkdownStyleSheet(
                        blockquoteAlign: WrapAlignment.start,
                        blockquotePadding:
                            const EdgeInsets.fromLTRB(20, 2, 2, 2),
                        blockquoteDecoration: BoxDecoration(
                            border: BorderDirectional(
                              start: BorderSide(
                                  width: 12, color: Colors.blueAccent.shade100),
                            ),
                            color: Colors.blueAccent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        h1: Theme.of(context).textTheme.headlineLarge,
                        h2: Theme.of(context).textTheme.headlineMedium,
                        code: Theme.of(context).textTheme.bodyMedium,
                        h2Align: WrapAlignment.center,
                        img: Theme.of(context).textTheme.headlineLarge),
                    styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                    imageDirectory: widget.imageDirectory,
                    builders: <String, MarkdownElementBuilder>{
                      'latex': LatexElementBuilder(
                        textScaleFactor: 1.4,
                      ),
                      'img': CenteredImageBuilder(
                        colorSelected: Theme.of(context).colorScheme.primary,
                        imageDir: widget.imageDirectory,
                      ),
                      'h1': CenteredHeaderBuilder(),
                      'table': TableElementBuilder(),
                      'code': CodeElementBuilder(
                          markdownPageWidth: MediaQuery.of(context).size.width,
                          colorSelectedBg: Theme.of(context)
                              .colorScheme
                              .surfaceVariant
                              .withOpacity(0.3),
                          colorSelectedPrimary:
                              Theme.of(context).colorScheme.primary,
                          useLightMode: widget.useLightMode),
                    },
                    extensionSet: md.ExtensionSet(
                      <md.BlockSyntax>[
                        ...md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                        ...md.ExtensionSet.gitHubWeb.blockSyntaxes,
                      ],
                      <md.InlineSyntax>[
                        md.EmojiSyntax(),
                        LatexInlineSyntax(),
                        ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
                      ],
                    ),
                  )));
            } else if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        const SizedBox(height: 10),
      ], //
    );
  }
}
