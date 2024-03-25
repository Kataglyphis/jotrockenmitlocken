import 'package:flutter/material.dart';

class CenteredBoxDecoration extends StatelessWidget {
  CenteredBoxDecoration(
      {super.key,
      this.child,
      this.insets = const EdgeInsets.all(0),
      this.margin = 0,
      this.borderRadius = 10,
      this.borderWidth = 5,
      required this.color});
  final Widget? child;
  EdgeInsets insets = const EdgeInsets.all(0);
  double margin = 0;
  double borderRadius = 10;
  double borderWidth = 5;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: insets,
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
}
