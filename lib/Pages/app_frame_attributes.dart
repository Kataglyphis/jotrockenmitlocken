import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/constants.dart';

class AppFrameAttributes {
  CurvedAnimation railAnimation;
  bool showMediumSizeLayout;
  bool showLargeSizeLayout;
  bool useOtherLanguageMode;
  ColorSeed colorSelected;
  AppFrameAttributes(
      {required this.railAnimation,
      required this.showMediumSizeLayout,
      required this.showLargeSizeLayout,
      required this.useOtherLanguageMode,
      required this.colorSelected});
}
