import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/constants.dart';

class VerticalScrollPage extends StatefulWidget {
  VerticalScrollPage({super.key, required this.childWidget});
  Widget childWidget;
  @override
  State<VerticalScrollPage> createState() => _VerticalScrollPage();
}

class _VerticalScrollPage extends State<VerticalScrollPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                widget.childWidget,
                // DocumentTable(
                //   colorSelected: widget.colorSelected,
                // ),
                const SizedBox(height: 10),
              ], //
            ));
      },
    );
  }
}
