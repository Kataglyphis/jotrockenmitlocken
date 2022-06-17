import 'package:flutter/material.dart';

import '../Navbar/Navbar.dart';

class LandingPage extends StatelessWidget {
  List<Widget> pageChildren(double width) {
    return <Widget>[
      NavBar(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: const Text(
                "Website \n for rendering enthusiasts",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.black),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: const Text(
                "Lets build epic rendering systems together",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black),
              ),
            ),
            Image.asset("assets/images/Engine_logo.png", width: width),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: pageChildren(constraints.biggest.width),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: pageChildren(constraints.biggest.width),
              ),
            );
          }
        },
      ),
    );
  }
}
