import 'dart:html' as html;
import 'package:flutter/foundation.dart';

void myPluginDownload(String url) {
  if (kReleaseMode) {
    url = "assets/$url";
  }
  html.AnchorElement anchorElement = html.AnchorElement(href: url);
  anchorElement.download = url;
  anchorElement.click();
}
