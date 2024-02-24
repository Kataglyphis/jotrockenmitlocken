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
        scaffoldKey: widget.scaffoldKey,
        showSecondList: false,
        childWidgetsLeftPage: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: mediumWidthBreakpoint.toInt(),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: widget.childWidgets,
                      )),
                ),
              ])
        ],
        childWidgetsRightPage: const [],
      ),
    );
  }
}
