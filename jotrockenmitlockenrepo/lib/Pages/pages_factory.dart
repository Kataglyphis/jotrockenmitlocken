import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/app_frame_attributes.dart';

abstract class PagesFactory {
  Widget createPage(AppFrameAttributes appFrameAttributes);
}
