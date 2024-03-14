import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/app_attributes.dart';

abstract class PagesFactory {
  Widget createPage(AppAttributes appFrameAttributes);
}
