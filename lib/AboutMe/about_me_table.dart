import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jotrockenmitlocken/constants.dart';

class AboutMeTable extends StatefulWidget {
  const AboutMeTable({Key? key}) : super(key: key);

  @override
  State<AboutMeTable> createState() => _AboutMeTableState();
}

class _AboutMeTableState extends State<AboutMeTable> {
  late Future<Map<String, dynamic>> _readJson;
  List keys = [];
  Map values = {};
  @override
  initState() {
    super.initState();
    _readJson = readJson();
  }

  // Fetch content from the json file
  Future<Map<String, dynamic>> readJson() async {
    final jsonData = await rootBundle.loadString('assets/data/aboutme.json');
    final Map<String, dynamic> list = json.decode(jsonData);
    var items = list as Map;
    keys = items.keys.toList();
    values = items;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          FutureBuilder(
              future: _readJson,
              builder: (context, data) {
                if (data.hasData) {
                  return Container(
                    height: 400,
                    child: ListView.builder(
                        itemCount: values.length,
                        itemBuilder: (context, index) {
                          if (constraints.maxWidth > desktopWidthThreshold) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: constraints.maxWidth / 4,
                                        height: 50,
                                        child: Text(keys[index] + " : ",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: constraints.maxWidth / 2,
                                        height: 50,
                                        child: Text(
                                          values[keys[index]],
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ], //
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: constraints.maxWidth / 3,
                                          height: 50,
                                          child: Text(keys[index] + " : ",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: constraints.maxWidth / 2,
                                        height: 50,
                                        child: Text(
                                          values[keys[index]],
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ], //
                              ),
                            );
                          }
                        }),
                  );
                } else if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      );
    });
  }
}
