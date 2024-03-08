import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/Media/Download/open_button.dart';
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
      return currentWidth;
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.7;
    } else {
      return currentWidth * 0.7;
    }
  }

  @override
  Widget visitElementAfter(md.Element img, TextStyle? preferredStyle) {
    String placeholderImage = "assets/images/Summy&Thundy.png";
    String displayedImage = placeholderImage;

    if (kReleaseMode) {
      placeholderImage = "assets/$placeholderImage";
    }

    String imageCaption = "placeholder";
    if (img.attributes['src'] != null) {
      displayedImage = "$imageDir/${img.attributes['src']!}";
    }
    if (kReleaseMode) {
      displayedImage = "assets/$displayedImage";
    }
    if (img.attributes['alt'] != null) {
      imageCaption = img.attributes['alt']!;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SelectionArea(
          child: Column(
            children: [
              SizedBox(
                width: getImageWidth(currentPageWidth),
                child: applyBoxDecoration(
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: FadeInImage(
                        filterQuality: FilterQuality.high,
                        placeholder: AssetImage(placeholderImage),
                        image: AssetImage(displayedImage),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OpenButton(
                            assetFullPath: displayedImage,
                          ),
                        )),
                  ]),
                  color: colorSelected,
                ),
              ),
              Text(
                imageCaption,
                style: preferredStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
