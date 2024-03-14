import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

class AppAttributes {
  CurvedAnimation railAnimation;
  bool showMediumSizeLayout;
  bool showLargeSizeLayout;

  bool useOtherLanguageMode;
  final void Function() handleLanguageChange;

  bool useLightMode;
  final void Function(bool useLightMode) handleBrightnessChange;

  ColorSeed colorSelected;
  final void Function(int value) handleColorSelect;

  AppAttributes(
      {required this.railAnimation,
      required this.showMediumSizeLayout,
      required this.showLargeSizeLayout,
      required this.useOtherLanguageMode,
      required this.colorSelected,
      required this.useLightMode,
      required this.handleBrightnessChange,
      required this.handleColorSelect,
      required this.handleLanguageChange});
}
