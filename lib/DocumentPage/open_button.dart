import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/DocumentPage/document.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
//import 'dart:html' as html;

@immutable
class DownloadButton extends StatelessWidget {
  Document document;
  DownloadButton({
    super.key,
    required this.document,
  });

  void _onPressed() async {
    if (kIsWeb) {
      //String url = baseDocumentDir + document.title;
      //html.window.open(url, "_blank");
    }
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).primaryColor;
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedColor,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      child: Text(
        "Open",
        style: FontHelper.getTextStyleSubHeadings(context),
      ),
    );
  }
}
