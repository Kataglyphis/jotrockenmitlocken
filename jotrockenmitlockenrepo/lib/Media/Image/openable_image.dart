import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Decoration/centered_box_decoration.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/Media/Open/open_button.dart';

class OpenableImage extends StatefulWidget {
  OpenableImage({
    super.key,
    required this.displayedImage,
    this.placeholderImage = "assets/images/Summy&Thundy_compressed.png",
    this.imageCaptioning,
    this.captioningStyle,
    this.disableOpen = false,
  }) {
    this.ourMainImage = FadeInImage(
      placeholder: AssetImage(placeholderImage),
      image: AssetImage(displayedImage),
    );
  }

  final String placeholderImage;
  final String displayedImage;
  final String? imageCaptioning;
  final TextStyle? captioningStyle;
  final bool disableOpen;
  late FadeInImage ourMainImage;

  @override
  State<StatefulWidget> createState() => _OpenableImageState();
}

class _OpenableImageState extends State<OpenableImage> {
  double imageWidth = 0;
  double imageHeight = 0;
  bool initializedImage = false;

  double getImageWidth(double imageWidth) {
    var currentPageWidth = MediaQuery.of(context).size.width;
    if (imageWidth < currentPageWidth) {
      return imageWidth;
    } else {
      return currentPageWidth * 0.9;
    }
  }

  late ImageStreamListener imageListener;

  @override
  Widget build(BuildContext context) {
    if (mounted && !initializedImage) {
      initializedImage = true;
      imageListener = ImageStreamListener((ImageInfo info, bool _) {
        setState(() {
          imageHeight = info.image.height.toDouble();
          double retrievedImageWidth = info.image.width.toDouble();
          imageWidth = getImageWidth(retrievedImageWidth).toDouble();
        });
      });
      widget.ourMainImage.image
          .resolve(const ImageConfiguration())
          .addListener(imageListener);
    } else if (initializedImage) {
      widget.ourMainImage.image
          .resolve(const ImageConfiguration())
          .removeListener(imageListener);
    }

    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: imageWidth,
          ),
          child: Stack(
            children: [
              CenteredBoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: widget.ourMainImage,
                ),
              ),
              if (!widget.disableOpen)
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OpenButton(
                        assetFullPath: widget.displayedImage,
                      ),
                    )),
            ],
          ),
        ),
        if (widget.imageCaptioning != null) ...[
          rowDivider,
          Text(
            widget.imageCaptioning!,
            style: (widget.captioningStyle != null)
                ? widget.captioningStyle!
                : null,
          ),
          rowDivider,
        ]
      ],
    );
  }
}
