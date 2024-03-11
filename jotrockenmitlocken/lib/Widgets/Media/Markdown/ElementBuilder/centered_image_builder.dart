import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlocken/Widgets/openable_image.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/Media/Download/open_button.dart';
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
  Widget visitElementAfter(md.Element img, TextStyle? preferredStyle) {
    String placeholderImage = "assets/images/Summy&Thundy_compressed.png";
    String displayedImage = placeholderImage;

    String imageCaption = "placeholder";
    if (img.attributes['src'] != null) {
      displayedImage = "$imageDir/${img.attributes['src']!}";
    }

    if (img.attributes['alt'] != null) {
      imageCaption = img.attributes['alt']!;
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
