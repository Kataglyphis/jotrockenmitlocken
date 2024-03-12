import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlocken/Widgets/openable_image.dart';
import 'package:markdown/markdown.dart' as md;

class CenteredImageBuilder extends MarkdownElementBuilder {
  CenteredImageBuilder(
      {required this.colorSelected,
      required this.imageDir,
      required this.currentPageWidth});
  Color colorSelected;
  String imageDir;
  double currentPageWidth;

  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    String placeholderImage = "assets/images/Summy&Thundy_compressed.png";
    String displayedImage = placeholderImage;

    String imageCaption = "placeholder";
    if (element.attributes['src'] != null) {
      displayedImage = "$imageDir/${element.attributes['src']!}";
    }

    if (element.attributes['alt'] != null) {
      imageCaption = element.attributes['alt']!;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SelectionArea(
            child: OpenableImage(
          currentPageWidth: currentPageWidth,
          placeholderImage: placeholderImage,
          displayedImage: displayedImage,
          imageCaptioning: imageCaption,
          captioningStyle: preferredStyle!,
          colorSelected: colorSelected,
        )),
      ],
    );
  }
}
