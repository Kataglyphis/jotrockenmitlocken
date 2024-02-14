import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Blog/blog.dart';
import 'package:jotrockenmitlocken/constants.dart';

class VerticalScrollPage extends StatefulWidget {
  VerticalScrollPage(
      {super.key, required this.childWidgets, required this.scaffoldKey});
  List<Widget> childWidgets;
  final GlobalKey<ScaffoldState> scaffoldKey;
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
        showNavBottomBar: false,
        scaffoldKey: widget.scaffoldKey,
        showSecondList: false,
        childWidgetsLeftPage: [
          Row(children: <Widget>[
            Flexible(
              flex: mediumWidthBreakpoint.toInt(),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: widget.childWidgets,
                shrinkWrap: true,
              ),
            ),
          ])
        ],
        childWidgetsRightPage: [],
      ),
    );
  }
}
