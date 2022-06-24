import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class AboutMeTable extends StatefulWidget {
  const AboutMeTable({Key? key}) : super(key: key);

  @override
  State<AboutMeTable> createState() => _AboutMeTableState();
}

class _AboutMeTableState extends State<AboutMeTable> {
  Future<List<List<dynamic>>> _loadCSV() async {
    final _rawData =
        await rootBundle.loadString("assets/data/Buecherliste.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    return _listData;
  }

  // Fetch content from the json file
  Future<Map<String, dynamic>> readJson() async {
    final jsonData = await rootBundle.loadString('assets/data/aboutme.json');
    final Map<String, dynamic> list = json.decode(jsonData);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          FutureBuilder(
              future: readJson(),
              builder: (context, data) {
                if (data.hasData) {
                  var items = data.data as Map;
                  var keys = items.keys.toList();
                  var values = items.entries.toList();

                  return Container(
                    height: 400,
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: constraints.maxWidth,
                                height: 50,
                                child: Center(
                                  child: Text(
                                      keys[index] + " : " + items[keys[index]],
                                      style: TextStyle(fontSize: 22)),
                                ),
                              ),
                            ], //
                          );
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
          FutureBuilder(
              future: _loadCSV(),
              builder: (context, data) {
                if (data.hasData) {
                  var items = data.data as List<List>;
                  // var keys = items.keys.toList();
                  // var values = items.entries.toList();
                  return Column(
                    children: [
                      Container(
                        height: 400,
                        child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: constraints.maxWidth,
                                    height: 50,
                                    child: Center(
                                      child: Text(items[index].toString(),
                                          style: TextStyle(fontSize: 22)),
                                    ),
                                  ),
                                ], //
                              );
                            }),
                      ),
                    ],
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
