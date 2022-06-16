import 'package:flutter/material.dart';
import 'package:website/LandingPage/LandingPage.dart';
import 'package:website/Navbar/Navbar.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 111, 188, 240),
                Color.fromARGB(255, 255, 255, 255)
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              NavBar(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                child: LandingPage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cataglyphis blog',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Montserrat"),
      home: MyHomePage(),
    );
  }
}

void main() {
  runApp(MyApp());
}
