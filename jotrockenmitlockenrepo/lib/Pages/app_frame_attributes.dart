import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

class AppFrameAttributes {
  CurvedAnimation railAnimation;
  bool showMediumSizeLayout;
  bool showLargeSizeLayout;
  bool useOtherLanguageMode;
  bool useLightMode;
  ColorSeed colorSelected;
  AppFrameAttributes(
      {required this.railAnimation,
      required this.showMediumSizeLayout,
      required this.showLargeSizeLayout,
      required this.useOtherLanguageMode,
      required this.colorSelected,
      required this.useLightMode});
}
