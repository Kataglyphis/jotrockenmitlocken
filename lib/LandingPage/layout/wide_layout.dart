import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/LandingPage/image_carousel.dart';
import 'package:jotrockenmitlocken/Navbar/navbar.dart';

import '../../constants.dart';

class WideLayout extends StatelessWidget {
  WideLayout({Key? key}) : super(key: key);

  List<Widget> pageChildren(BuildContext context) {
    return <Widget>[
      const NavBar(),
      ImageCarousel(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 800,
          decoration: BoxDecoration(
            //color: Color.fromARGB(255, 171, 242, 255)),
            image: DecorationImage(
              image: AssetImage("assets/images/maxresdefault.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40, horizontal: 100.0),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Website \nfor rendering\nenthusiasts",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 80.0,
                          color: kPrimaryColor),
                    ),
                    const Text(
                      "Lets build rendering systems together",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: const Text(
                    "Blog",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/blog');
                  },
                ),
                //Image.asset("assets/images/Engine_logo.png", width: 800),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 800,
          decoration: BoxDecoration(
            //color: Color.fromARGB(255, 171, 242, 255)),
            image: DecorationImage(
              image: AssetImage("assets/images/SkinSegmentation.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40, horizontal: 100.0),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Website \nfor machine learning\nenthusiasts",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60.0,
                          color: kPrimaryColor),
                    ),
                    const Text(
                      "Lets build AI",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: const Text(
                    "Blog",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/blog');
                  },
                ),
                //Image.asset("assets/images/Engine_logo.png", width: 800),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 800,
          decoration: BoxDecoration(
            //color: Color.fromARGB(255, 171, 242, 255)),
            image: DecorationImage(
              image: AssetImage("assets/images/flat_barbell_6015194.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 100.0),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Website \nfor lifting enthusiasts",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60.0,
                          color: Colors.black),
                    ),
                    const Text(
                      "Lets lift together",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          color: Colors.black),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: const Text(
                    "Blog",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/blog');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: pageChildren(context),
      ),
    );
  }
}
