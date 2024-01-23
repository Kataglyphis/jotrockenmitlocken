import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/constants.dart';

Widget applyBoxDecoration(Widget child, EdgeInsets insets, double margin,
    double borderRadius, double borderWidth, Color color) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      padding: insets, //EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: color,
          width: borderWidth,
        ),
      ),
      child: child,
    ),
  );
}

TextStyle getTextStyleHeadings(BuildContext context) {
  var currentWidth = MediaQuery.of(context).size.width;
  if (currentWidth <= narrowScreenWidthThreshold) {
    return const TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold); // , color: Colors.black
  } else if (currentWidth <= largeWidthBreakpoint) {
    return const TextStyle(
        fontSize: 36, fontWeight: FontWeight.bold); // , color: Colors.black
  } else {
    return const TextStyle(
        fontSize: 36, fontWeight: FontWeight.bold); // , color: Colors.black
  }
}

TextStyle getTextStyleSubHeadings(BuildContext context) {
  var currentWidth = MediaQuery.of(context).size.width;
  if (currentWidth <= narrowScreenWidthThreshold) {
    return const TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold); // , color: Colors.black
  } else if (currentWidth <= largeWidthBreakpoint) {
    return const TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold); // , color: Colors.black
  } else {
    return const TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold); // , color: Colors.black
  }
}
