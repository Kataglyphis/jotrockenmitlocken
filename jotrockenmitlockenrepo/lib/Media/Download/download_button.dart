import 'package:flutter/material.dart';

import 'download_stub.dart' if (dart.library.html) 'download_web.dart';

class DownloadButton extends StatelessWidget {
  final String assetFullPath;
  const DownloadButton({
    super.key,
    required this.assetFullPath,
  });

  void _onPressed() async {
    myPluginDownload(assetFullPath);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.file_download,
        size: 44,
      ),
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }
}
