import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/about_me_table.dart';
import 'package:jotrockenmitlocken/constants.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({
    Key? key,
    required this.useOtherLanguageMode,
  }) : super(key: key);
  final bool useOtherLanguageMode;
  @override
  State<AboutMePage> createState() =>
      _AboutMePageState(useOtherLanguageMode: useOtherLanguageMode);
}

class _AboutMePageState extends State<AboutMePage> {
  _AboutMePageState({
    Key? key,
    required this.useOtherLanguageMode,
  });
  final bool useOtherLanguageMode;

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
              AboutMeTable(useOtherLanguageMode: useOtherLanguageMode)
            ],
          );
        } else {
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              AboutMeTable(useOtherLanguageMode: useOtherLanguageMode)
            ],
          );
        }
      },
    ));
  }
}
