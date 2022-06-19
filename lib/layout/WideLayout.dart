import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Navbar/Navbar.dart';

class WideLayout extends StatelessWidget {
  const WideLayout({Key? key}) : super(key: key);

  List<Widget> pageChildren() {
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
            Image.asset("assets/images/Engine_logo.png", width: 800),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: pageChildren(),
      ),
    );
  }
}
