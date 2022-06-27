import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/LandingPage/layout/narrow_layout.dart';
import 'package:jotrockenmitlocken/LandingPage/layout/wide_layout.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/navigation_drawer_widget.dart';
import 'package:jotrockenmitlocken/constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > desktopWidthThreshold) {
          return Scaffold(body: WideLayout());
        } else {
          return Scaffold(
              drawer: const NavigationDrawerWidget(),
              appBar: AppBar(
                title: const Text(appName),
                backgroundColor: kPrimaryColor,
                centerTitle: true,
              ),
              body: NarrowLayout());
        }
      },
    );
  }
}
