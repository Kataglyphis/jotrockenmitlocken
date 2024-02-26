import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/constants.dart';

class FontHelper {
  static TextStyle getTextStyle(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return const TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal); // , color: Colors.black
    } else if (currentWidth <= largeWidthBreakpoint) {
      return const TextStyle(
          fontSize: 20, fontWeight: FontWeight.normal); // , color: Colors.black
    } else {
      return const TextStyle(
          fontSize: 20, fontWeight: FontWeight.normal); // , color: Colors.black
    }
  }

  static TextStyle getTextStyleHeadings(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return const TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold); // , color: Colors.black
    } else if (currentWidth <= largeWidthBreakpoint) {
      return const TextStyle(
          fontSize: 34, fontWeight: FontWeight.bold); // , color: Colors.black
    } else {
      return const TextStyle(
          fontSize: 34, fontWeight: FontWeight.bold); // , color: Colors.black
    }
  }

  static TextStyle getTextStyleSubHeadings(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold); // , color: Colors.black
    } else if (currentWidth <= largeWidthBreakpoint) {
      return const TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold); // , color: Colors.black
    } else {
      return const TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold); // , color: Colors.black
    }
  }
}
