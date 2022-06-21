import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/layout/about_me_narrow_layout.dart';
import 'package:jotrockenmitlocken/AboutMe/layout/about_me_wide_layout.dart';
import 'package:jotrockenmitlocken/constants.dart';

import '../Navbar/mobile/navigation_drawer_widget.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            body: AboutMeWideLayout(),
          );
        } else {
          return Scaffold(
            drawer: const NavigationDrawerWidget(),
            appBar: AppBar(
              title: const Text(appName),
              backgroundColor: kPrimaryColor,
              centerTitle: true,
            ),
            body: AboutMeNarrowLayout(),
          );
        }
      },
    );
  }
}
