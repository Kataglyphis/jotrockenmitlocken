import 'package:flutter/material.dart';

class FirstComponentList extends StatefulWidget {
  const FirstComponentList({
    super.key,
    required this.showSecondList,
    required this.childWidgetsLeftPage,
    required this.childWidgetsRightPage,
  });

  final bool showSecondList;
  final List<Widget> childWidgetsLeftPage;
  final List<Widget> childWidgetsRightPage;

  @override
  State<FirstComponentList> createState() => _FirstComponentListState();
}

class _FirstComponentListState extends State<FirstComponentList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> resultingChildWidgetsLeftPage = widget.childWidgetsLeftPage;
    if (!widget.showSecondList) {
      resultingChildWidgetsLeftPage =
          widget.childWidgetsLeftPage + widget.childWidgetsRightPage;
    }
    return ListView(
      children: resultingChildWidgetsLeftPage,
    ); //ScrollableList(childWidgets: resultingChildWidgetsLeftPage);
  }
}
