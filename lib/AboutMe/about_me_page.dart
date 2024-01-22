import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/about_me_table.dart';
import 'package:jotrockenmitlocken/constants.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({
    super.key,
    required this.useOtherLanguageMode,
    required this.colorSelected,
  });
  final bool useOtherLanguageMode;
  final ColorSeed colorSelected;
  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  _AboutMePageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > narrowScreenWidthThreshold) {
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              AboutMeTable(
                useOtherLanguageMode: widget.useOtherLanguageMode,
                colorSelected: widget.colorSelected,
              )
            ],
          );
        } else {
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              AboutMeTable(
                  useOtherLanguageMode: widget.useOtherLanguageMode,
                  colorSelected: widget.colorSelected)
            ],
          );
        }
      },
    ));
  }
}
