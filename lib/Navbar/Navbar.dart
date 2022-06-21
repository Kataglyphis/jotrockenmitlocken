import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/constants.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const DesktopNavbar();
  }
}

class DesktopNavbar extends StatelessWidget {
  const DesktopNavbar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          const Text(
            appName,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
          ),
          SizedBox(width: 16),
          Image.asset("assets/images/barbell.png", width: 64),
          Spacer(),
          Row(children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                "Home",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            const SizedBox(width: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                "About me",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/aboutMe');
              },
            ),
            const SizedBox(width: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                "Blog",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/blog');
              },
            ),
          ]),
        ]),
      ),
    );
  }
}
