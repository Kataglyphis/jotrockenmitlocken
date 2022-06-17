import 'package:flutter/material.dart';

import 'AboutMe/AboutMePage.dart';
import 'Blog/BlogLandingPage.dart';
import 'LandingPage/LandingPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cataglyphis blog',
      initialRoute: '/',
      routes: {
        '/': ((context) => LandingPage()),
        '/aboutMe': ((context) => const AboutMePage()),
        '/blog': ((context) => const BlogLandingPage()),
      },
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Montserrat"),
    );
  }
}

void main() {
  runApp(MyApp());
}
