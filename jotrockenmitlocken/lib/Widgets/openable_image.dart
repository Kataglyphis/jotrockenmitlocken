import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/Media/Open/open_button.dart';

class OpenableImage extends StatefulWidget {
  const OpenableImage(
      {super.key,
      required this.placeholderImage,
      required this.displayedImage,
      required this.currentPageWidth,
      required this.colorSelected,
      required this.imageCaptioning,
      required this.captioningStyle});

  final String placeholderImage;
  final String displayedImage;
  final double currentPageWidth;
  final Color colorSelected;
  final String imageCaptioning;
  final TextStyle captioningStyle;

  @override
  State<StatefulWidget> createState() => _OpenableImageState();
}

class _OpenableImageState extends State<OpenableImage> {
  double imageWidth = 0;
  var imageHeight = 0;

  double getImageWidth(double currentWidth, double imageWidth) {
    if (imageWidth < currentWidth) {
      return imageWidth;
    } else {
      return currentWidth * 0.95;
    }
  }

  @override
  Widget build(BuildContext context) {
    FadeInImage ourMainImage = FadeInImage(
      filterQuality: FilterQuality.high,
      placeholder: AssetImage(widget.placeholderImage),
      image: AssetImage(widget.displayedImage),
    );

    ourMainImage.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        imageHeight = info.image.height;
        imageWidth = info.image.width.toDouble();
        imageWidth =
            getImageWidth(widget.currentPageWidth, imageWidth).toDouble();
      });
    }));

    String openButtonImage = widget.displayedImage;
    if (kReleaseMode) {
      openButtonImage = "assets/$widget.displayedImage";
    }
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: imageWidth,
          ),
          child: Stack(
            children: [
              applyBoxDecoration(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: ourMainImage,
                ),
                color: widget.colorSelected,
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
          widget.imageCaptioning,
          style: widget.captioningStyle,
        ),
      ],
    );
  }
}
