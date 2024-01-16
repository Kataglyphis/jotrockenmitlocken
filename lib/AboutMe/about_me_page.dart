import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/about_me_table.dart';
import 'package:jotrockenmitlocken/constants.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({
    Key? key,
  }) : super(key: key);
  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > narrowScreenWidthThreshold) {
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: const <Widget>[AboutMeTable()],
          );
        } else {
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: const <Widget>[AboutMeTable()],
          );
        }
      },
    ));
  }
}
