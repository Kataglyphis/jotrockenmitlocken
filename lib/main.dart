import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Navbar/mobile/navigation_drawer_change_notifier.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:provider/provider.dart';

import 'AboutMe/about_me_page.dart';
import 'Blog/blog_landing_page.dart';
import 'LandingPage/landing_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

final themeMode = ValueNotifier(2);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NavigationDrawerChangeNotifier(),
        child: ValueListenableBuilder(
          builder: (context, value, g) {
            return MaterialApp(
              title: 'Cataglyphis blog',
              initialRoute: '/',
              routes: {
                '/': ((context) => const LandingPage()),
                '/aboutMe': ((context) => const AboutMePage()),
                '/blog': ((context) => const BlogLandingPage()),
              },
              theme: ThemeData(
                  primaryColor: kPrimaryColor, fontFamily: "Montserrat"),
            );
          },
          valueListenable: themeMode,
        ),
      );
}

void main() {
  runApp(const MyApp());
}
