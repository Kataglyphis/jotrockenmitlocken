import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

abstract class PagesFactory {
  Widget createPage(AppAttributes appAttributes, BuildContext context);
}
