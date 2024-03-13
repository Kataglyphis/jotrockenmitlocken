import 'package:flutter/material.dart';

class GridCreator {
  static Widget createAdaptiveGridOfWidgets(MainAxisAlignment rowAlignment,
      int maxgridWidgetsPerRow, List<Widget> gridWidgets) {
    final int maxNumRows = (gridWidgets.length / maxgridWidgetsPerRow).ceil();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < maxNumRows; i++)
            //(i*maxNumRows >= widget.footerPagesConfig.length) ?
            Row(
                mainAxisAlignment: rowAlignment,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int j = 0; j < maxgridWidgetsPerRow; j++)
                    if (i * maxgridWidgetsPerRow + j < gridWidgets.length)
                      gridWidgets[i * maxgridWidgetsPerRow + j],
                ])
        ]);
  }
}
