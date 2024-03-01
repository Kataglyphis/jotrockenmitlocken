import 'package:flutter/material.dart';

import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/github.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:jotrockenmitlockenrepo/constants.dart';

class CodeElementBuilder extends MarkdownElementBuilder {
  CodeElementBuilder({required this.colorSelected}) {
    vsThemeCustomized['root'] = TextStyle(
        fontWeight: FontWeight.w100,
        backgroundColor: colorSelected.color.withAlpha(10),
        color: Color(0xff000000));
  }
  ColorSeed colorSelected;
  Map<String, TextStyle> vsThemeCustomized = {...githubTheme};
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }

    if (language == 'math') {
      return Center(
        child: applyBoxDecoration(
            child: SelectableMath.tex(
              element.textContent,
              textStyle: preferredStyle,
              // mathStyle: mathStyle,
              textScaleFactor: 1.6,
            ),
            color: colorSelected.color.withAlpha(10)),
      );
    }
    return Center(
      child: applyBoxDecoration(
          child: HighlightView(
            // The original code to be highlighted
            element.textContent,
            // Specify language
            // It is recommended to give it a value for performance
            language: language,
            theme: vsThemeCustomized,
            // Specify padding
            padding: const EdgeInsets.all(8),
          ),
          color: colorSelected.color.withAlpha(10)),
    );
  }
}
