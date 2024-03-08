import 'package:flutter/material.dart';

import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/github.dart';
import 'package:flutter_highlighter/themes/dracula.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:markdown/markdown.dart' as md;

class CodeElementBuilder extends MarkdownElementBuilder {
  CodeElementBuilder({required this.colorSelected, required this.useLightMode});

  Map<String, TextStyle> getCodeTheme() {
    if (useLightMode) {
      lightThemeCodeStyle['root'] = TextStyle(
        //fontWeight: FontWeight.w100,
        backgroundColor: colorSelected,
      );
      return lightThemeCodeStyle;
    } else {
      darkThemeCodeStyle['root'] = TextStyle(
        //fontWeight: FontWeight.w100,
        backgroundColor: colorSelected,
      );
      return darkThemeCodeStyle;
    }
  }

  bool useLightMode;
  Color colorSelected;
  Map<String, TextStyle> lightThemeCodeStyle = {...githubTheme};
  Map<String, TextStyle> darkThemeCodeStyle = {...draculaTheme};

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
            applyBoxDecoration(
                child: Container(
                  color: colorSelected,
                  child: Math.tex(
                    element.textContent,
                    textStyle: preferredStyle,

                    // mathStyle: mathStyle,
                    textScaleFactor: 1.6,
                  ),
                ),
                insets: const EdgeInsets.all(2),
                borderWidth: 1),
          ],
        ),
      ));
    }
    return SelectionArea(
      child: Center(
        child: applyBoxDecoration(
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
      ),
    );
  }
}
