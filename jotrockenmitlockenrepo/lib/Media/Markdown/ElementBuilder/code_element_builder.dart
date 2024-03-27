import 'package:flutter/material.dart';

import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/github.dart';
import 'package:flutter_highlighter/themes/dracula.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:jotrockenmitlockenrepo/Decoration/centered_box_decoration.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:jotrockenmitlockenrepo/Media/copy_button.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

class CodeElementBuilder extends MarkdownElementBuilder {
  CodeElementBuilder(
      {required this.colorSelectedBg,
      required this.useLightMode,
      required this.colorSelectedPrimary,
      required this.markdownPageWidth});

  Map<String, TextStyle> getCodeTheme() {
    if (useLightMode) {
      lightThemeCodeStyle['root'] = TextStyle(
        //fontWeight: FontWeight.w100,
        backgroundColor: colorSelectedBg,
      );
      return lightThemeCodeStyle;
    } else {
      darkThemeCodeStyle['root'] = TextStyle(
        //fontWeight: FontWeight.w100,
        backgroundColor: colorSelectedBg,
      );
      return darkThemeCodeStyle;
    }
  }

  bool useLightMode;
  Color? colorSelectedBg;
  Color colorSelectedPrimary;
  Map<String, TextStyle> lightThemeCodeStyle = {...githubTheme};
  Map<String, TextStyle> darkThemeCodeStyle = {...draculaTheme};
  double markdownPageWidth;

  @override
  Widget visitElementAfterWithContext(BuildContext context, md.Element element,
      TextStyle? preferredStyle, TextStyle? parentStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }

    if (language == 'math') {
      return Center(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            CenteredBoxDecoration(
              insets: const EdgeInsets.all(2),
              borderWidth: 1,
              color: colorSelectedPrimary,
              child: Container(
                color: colorSelectedBg,
                child: Math.tex(
                  element.textContent,
                  textStyle: preferredStyle,
                  textScaleFactor: 1.6,
                ),
              ),
            ),
          ],
        ),
      ));
    }
    return Center(
      child: Column(
        children: [
          Container(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: (markdownPageWidth > narrowScreenWidthThreshold)
                      ? Theme.of(context)
                          .colorScheme
                          .surfaceVariant
                          .withOpacity(0.3)
                      : null,
                  child: CenteredBoxDecoration(
                      color: colorSelectedPrimary,
                      child: Stack(children: [
                        Center(
                          child: HighlightView(
                            tabSize: 4,
                            // The original code to be highlighted
                            element.textContent,
                            // Specify language
                            // It is recommended to give it a value for performance
                            language: language,
                            theme: getCodeTheme(),
                            textStyle: preferredStyle,
                            // Specify padding
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CopyButton(
                                text: element.textContent,
                              ),
                            ))
                      ]))))
        ],
      ),
    );
  }
}
