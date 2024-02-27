import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';

abstract class PagesFactory {
  Widget createPage(AppFrameAttributes appFrameAttributes);
}
