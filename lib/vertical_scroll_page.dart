import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/constants.dart';

class VerticalScrollPage extends StatefulWidget {
  VerticalScrollPage({super.key, required this.childWidgets});
  List<Widget> childWidgets;
  @override
  State<VerticalScrollPage> createState() => _VerticalScrollPage();
}

class _VerticalScrollPage extends State<VerticalScrollPage> {
  double getPageWidth() {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return currentWidth;
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.75;
    } else {
      return currentWidth * 0.75;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(children: <Widget>[
          Flexible(
            flex: mediumWidthBreakpoint.toInt(),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: widget.childWidgets,
              shrinkWrap: true,
            ),
          ),
        ]);
      },
    );
  }
}
