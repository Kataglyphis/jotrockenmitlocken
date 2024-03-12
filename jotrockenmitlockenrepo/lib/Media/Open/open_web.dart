import 'dart:html' as html;

import 'package:flutter/foundation.dart';

void myPluginOpen(String url) {
  if (kReleaseMode) {
    url = "assets/$url";
  }
  html.window.open(url, "_blank");
}
