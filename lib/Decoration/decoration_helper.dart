import 'package:flutter/material.dart';

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
