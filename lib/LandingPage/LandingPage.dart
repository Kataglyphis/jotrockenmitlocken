import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/NavigationDrawerWidget.dart';
import 'package:jotrockenmitlocken/layout/NarrowLayout.dart';
import 'package:jotrockenmitlocken/layout/WideLayout.dart';

import '../Navbar/Navbar.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          return Scaffold(body: WideLayout());
        } else {
          return Scaffold(
              drawer: NavigationDrawerWidget(),
              appBar: AppBar(
                title: Text("Jotrockenmitlocken"),
                backgroundColor: Colors.red,
                centerTitle: true,
              ),
              body: NarrowLayout());
        }
      },
    );
  }
}
