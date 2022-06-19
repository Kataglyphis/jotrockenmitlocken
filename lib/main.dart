import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/NavigationDrawerChangeNotifier.dart';
import 'package:jotrockenmitlocken/info.dart';
import 'package:provider/provider.dart';

import 'AboutMe/AboutMePage.dart';
import 'Blog/BlogLandingPage.dart';
import 'LandingPage/LandingPage.dart';

import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NavigationDrawerChangeNotifier(),
        child: MaterialApp(
          title: 'Cataglyphis blog',
          initialRoute: '/',
          routes: {
            '/': ((context) => LandingPage()),
            '/aboutMe': ((context) => const AboutMePage()),
            '/blog': ((context) => const BlogLandingPage()),
            '/info': ((context) => const Info())
          },
          theme:
              ThemeData(primarySwatch: Colors.blue, fontFamily: "Montserrat"),
        ),
      );
}

void main() {
  runApp(MyApp());
}
