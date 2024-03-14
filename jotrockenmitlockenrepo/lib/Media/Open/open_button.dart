import 'package:flutter/material.dart';

import 'open_stub.dart' if (dart.library.html) 'open_web.dart';

import 'package:mime/mime.dart';

import 'package:flutter/foundation.dart';

class OpenButton extends StatelessWidget {
  late final String assetFullPath;
  OpenButton({
    super.key,
    required String assetPath,
  }) {
    if (kReleaseMode) {
      assetFullPath = "assets/$assetPath";
    } else {
      assetFullPath = assetPath;
    }
  }

  void _onPressed() async {
    myPluginOpen(assetFullPath);
  }

  // https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
  bool isDisabled() {
    String? mimType = lookupMimeType(assetFullPath);
    if (mimType != null) {
      if (mimType.startsWith('image') || mimType == 'application/pdf') {
        return false;
      }
      return true;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled() ? null : _onPressed,
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
