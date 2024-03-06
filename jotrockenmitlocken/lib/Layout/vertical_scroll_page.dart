import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Layout/Widgets/first_component_list.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

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
    return Expanded(
      child: FirstComponentList(
        showSecondList: false,
        childWidgetsLeftPage: [...widget.childWidgets],
        childWidgetsRightPage: const [],
      ),
    );
  }
}
