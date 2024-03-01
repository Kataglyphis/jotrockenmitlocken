import 'package:flutter/material.dart';

Widget applyBoxDecoration(
    {Widget? child,
    EdgeInsets insets = const EdgeInsets.all(0),
    double margin = 0,
    double borderRadius = 10,
    double borderWidth = 5,
    Color color = (Colors.greenAccent)}) {
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
