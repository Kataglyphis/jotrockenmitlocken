import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/LandingPage/image_carousel.dart';

import '../../Navbar/navbar.dart';
import '../../constants.dart';

class NarrowLayout extends StatelessWidget {
  NarrowLayout({Key? key}) : super(key: key);

  List<Widget> pageChildren(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return <Widget>[
      ImageCarousel(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: media.size.height * 0.8,
          width: media.size.width,
          decoration: BoxDecoration(
            //color: Color.fromARGB(255, 171, 242, 255)),
            image: DecorationImage(
              alignment: Alignment.centerRight,
              image: AssetImage("assets/images/maxresdefault.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Rendering",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white),
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
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: media.size.height,
          width: media.size.width,
          decoration: BoxDecoration(
            //color: Color.fromARGB(255, 171, 242, 255)),
            image: DecorationImage(
              image: AssetImage("assets/images/SkinSegmentation.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Machine learning",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white),
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
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: media.size.height * 0.5,
          width: media.size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/flat_barbell_6015194.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Lifting",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
