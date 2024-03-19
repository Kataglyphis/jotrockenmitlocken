import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/LandingPage/landig_page_entry.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

abstract class LandingPageEntryFactory {
  String routerPath;
  LandingPageEntryFactory({required this.routerPath});
  LandingPageEntry createLandingPageEntry(
      AppAttributes appAttributes, BuildContext context);
}
