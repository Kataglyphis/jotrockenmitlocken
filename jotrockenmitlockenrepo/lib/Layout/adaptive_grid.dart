import 'package:flutter/material.dart';

class AdaptiveGrid extends StatefulWidget {
  final MainAxisAlignment rowAlignment;
  final int maxgridWidgetsPerRow;
  final List<Widget> gridWidgets;

  const AdaptiveGrid(
      {super.key,
      required this.rowAlignment,
      required this.maxgridWidgetsPerRow,
      required this.gridWidgets});

  @override
  State<StatefulWidget> createState() => AdaptiveGridState();
}

class AdaptiveGridState extends State<AdaptiveGrid> {
  @override
  Widget build(BuildContext context) {
    final int maxNumRows =
        (widget.gridWidgets.length / widget.maxgridWidgetsPerRow).ceil();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < maxNumRows; i++)
            Row(
                mainAxisAlignment: widget.rowAlignment,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int j = 0; j < widget.maxgridWidgetsPerRow; j++)
                    if (i * widget.maxgridWidgetsPerRow + j <
                        widget.gridWidgets.length)
                      widget.gridWidgets[i * widget.maxgridWidgetsPerRow + j],
                ])
        ]);
  }
}
