import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'download_stub.dart' if (dart.library.html) 'download_web.dart';

@immutable
class OpenButton extends StatelessWidget {
  String assetFullPath;
  OpenButton({
    super.key,
    required this.assetFullPath,
  });

  void _onPressed() async {
    myPluginDownload(assetFullPath);
    if (kIsWeb) {
      //String url = baseDocumentDir + document.title;
      //html.window.open(url, "_blank");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      child: Text(
        "Open",
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
