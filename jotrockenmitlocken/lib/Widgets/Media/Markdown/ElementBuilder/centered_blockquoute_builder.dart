import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class CenteredBlockQuoteBuilder extends MarkdownElementBuilder {
  CenteredBlockQuoteBuilder({required this.useLightMode});
  bool useLightMode;
  @override
  Widget visitElementAfterWithContext(BuildContext context, md.Element element,
      TextStyle? preferredStyle, TextStyle? parentStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }

    return Center(child: Text(""));
  }
}
