import 'package:flutter/material.dart';

class PieChartDataEntry {
  PieChartDataEntry(this.x, this.y, [this.color = Colors.black]);
  final String x;
  final double y;
  final Color color;
}
