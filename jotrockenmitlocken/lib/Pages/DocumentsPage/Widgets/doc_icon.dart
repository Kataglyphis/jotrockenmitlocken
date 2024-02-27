import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/Widgets/document.dart';

@immutable
class DocIcon extends StatelessWidget {
  Document document;
  DocIcon({super.key, required this.document});

  void _onPressed() {
    // if (kIsWeb) {
    //   String url = baseDocumentDir + document.title;

    //   //js.context.callMethod('download', [url]);
    //   html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    //   anchorElement.download = url;
    //   anchorElement.click();
    // }
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).primaryColor;
    return AspectRatio(
      aspectRatio: 1,
      child: FittedBox(
        child: SizedBox(
          width: 80,
          height: 80,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: selectedColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: IconButton(
                tooltip: 'Download document',
                onPressed: () {
                  _onPressed();
                },
                icon: const Icon(Icons.file_download),
                color: Colors.white,
                iconSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
