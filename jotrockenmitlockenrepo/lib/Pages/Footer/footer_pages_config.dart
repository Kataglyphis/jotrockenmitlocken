import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_config.dart';

abstract class FooterPagesConfig extends PagesConfig {
  FooterPagesConfig({required super.routingName, required super.pagesCreator});
  String getHeading(BuildContext context);
}
