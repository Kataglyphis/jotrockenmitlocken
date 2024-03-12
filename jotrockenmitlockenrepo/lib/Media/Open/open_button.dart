import 'package:flutter/material.dart';

import 'open_stub.dart' if (dart.library.html) 'open_web.dart';

class OpenButton extends StatelessWidget {
  final String assetFullPath;
  const OpenButton({
    super.key,
    required this.assetFullPath,
  });

  void _onPressed() async {
    myPluginOpen(assetFullPath);
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
