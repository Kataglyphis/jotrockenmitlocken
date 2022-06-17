import 'package:flutter/material.dart';

import '../Navbar/Navbar.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NavBar(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset("assets/images/Me.jpg", width: 200),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child:
                  Image.asset("assets/images/Paypal_QR_Code.png", width: 200),
            ),
            const Text(
              "Jonas Heinle\n Some dude interested in various topics. Some text that describes me lorem ipsum ipsum lorem renderdude@jotrockenmitlocken.de",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
