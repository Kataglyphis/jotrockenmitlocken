import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:markdown/markdown.dart' as md;

class CenteredImageBuilder extends MarkdownElementBuilder {
  CenteredImageBuilder({required this.colorSelected, required this.imageDir});
  ColorSeed colorSelected;
  String imageDir;
  @override
  Widget visitElementAfter(md.Element img, TextStyle? preferredStyle) {
    String displayedImage = "";
    if (img.attributes['src'] != null) {
      displayedImage = imageDir + "/" + img.attributes['src']!;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        applyBoxDecoration(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: FadeInImage(
              filterQuality: FilterQuality.medium,
              placeholder: AssetImage(displayedImage),
              image: AssetImage(displayedImage),
            ),
          ),
          color: colorSelected.color.withAlpha(60),
        ),
      ],
    );
  }
}
