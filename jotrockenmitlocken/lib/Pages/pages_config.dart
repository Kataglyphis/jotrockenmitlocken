import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/pages_factory.dart';

class PagesConfig {
  String routingName;
  PagesFactory pagesCreator;
  PagesConfig({required this.routingName, required this.pagesCreator});
}
