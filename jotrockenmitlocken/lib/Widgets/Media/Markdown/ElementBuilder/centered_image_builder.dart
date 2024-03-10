import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
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

  double getImageWidth(double currentWidth, double imageWidth) {
    if (imageWidth < currentWidth) {
      return imageWidth;
    }

    if (currentWidth <= narrowScreenWidthThreshold) {
      return currentWidth * 0.95;
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.95;
    } else {
      return currentWidth * 0.95;
    }
  }

  @override
  Widget visitElementAfter(md.Element img, TextStyle? preferredStyle) {
    final _key = GlobalKey();

    String placeholderImage = "assets/images/Summy&Thundy.png";
    String displayedImage = placeholderImage;

    String imageCaption = "placeholder";
    if (img.attributes['src'] != null) {
      displayedImage = "$imageDir/${img.attributes['src']!}";
    }

    String openButtonImage = displayedImage;
    if (kReleaseMode) {
      openButtonImage = "assets/$displayedImage";
    }
    if (img.attributes['alt'] != null) {
      imageCaption = img.attributes['alt']!;
    }

    FadeInImage ourMainImage = FadeInImage(
      key: _key,
      filterQuality: FilterQuality.high,
      placeholder: AssetImage(displayedImage),
      image: AssetImage(displayedImage),
    );

    double imageWidth = 0; //getImageWidth(currentPageWidth);
    var imageHeight = 0;

    ourMainImage.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      imageHeight = info.image.height;
      imageWidth = info.image.width.toDouble();
      imageWidth = getImageWidth(currentPageWidth, imageWidth).toDouble();
    }));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SelectionArea(
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: imageWidth,
                  //getImageWidth(currentPageWidth, imageWidth.toDouble()),
                ),
                child: Stack(
                  children: [
                    applyBoxDecoration(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: ourMainImage,
                      ),
                      color: colorSelected,
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OpenButton(
                            assetFullPath: openButtonImage,
                          ),
                        )),
                  ],
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
