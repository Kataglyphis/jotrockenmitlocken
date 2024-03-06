import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:markdown/markdown.dart' as md;

class CenteredImageBuilder extends MarkdownElementBuilder {
  CenteredImageBuilder(
      {required this.colorSelected,
      required this.imageDir,
      required this.currentPageWidth});
  Color colorSelected;
  String imageDir;
  double currentPageWidth;

  double getImageWidth(double currentWidth) {
    if (currentWidth <= narrowScreenWidthThreshold) {
      return currentWidth * 0.9;
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.7;
    } else {
      return currentWidth * 0.7;
    }
  }

  @override
  Widget visitElementAfter(md.Element img, TextStyle? preferredStyle) {
    String displayedImage = "assets/images/Summy&Thundy.png";
    String imageCaption = "placeholder";
    if (img.attributes['src'] != null) {
      displayedImage = imageDir + "/" + img.attributes['src']!;
    }
    if (img.attributes['alt'] != null) {
      imageCaption = img.attributes['alt']!;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            SizedBox(
              width: getImageWidth(currentPageWidth),
              child: applyBoxDecoration(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: FadeInImage(
                    filterQuality: FilterQuality.medium,
                    placeholder:
                        AssetImage("assets/images/Summy&Thundy_compressed.png"),
                    image: AssetImage(displayedImage),
                  ),
                ),
                color: colorSelected,
              ),
            ),
            Text(
              imageCaption,
              style: preferredStyle,
            ),
          ],
        ),
      ],
    );
  }
}
