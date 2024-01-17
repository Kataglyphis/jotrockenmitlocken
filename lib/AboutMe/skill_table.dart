import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/constants.dart';

class SkillTable extends StatefulWidget {
  const SkillTable({Key? key, required this.useOtherLanguageMode})
      : super(key: key);
  final bool useOtherLanguageMode;
  @override
  State<SkillTable> createState() => _SkillTableState();
}

class _SkillTableState extends State<SkillTable> {
  _SkillTableState();
  late Future<Map<String, dynamic>> _readJsonEn;
  late Future<Map<String, dynamic>> _readJsonDe;
  List keysEn = [];
  List keysDe = [];
  List<List<dynamic>> valuesDe = [];
  List<List<dynamic>> valuesEn = [];
  String aboutMeFileDe = 'assets/data/aboutme_de.json';
  String aboutMeFileEn = 'assets/data/aboutme_en.json';
  late bool langDeActive;

  @override
  initState() {
    super.initState();
    _readJsonDe = readJsonDe(aboutMeFileDe);
    _readJsonEn = readJsonEn(aboutMeFileEn);
  }

  // Fetch content from the json file
  Future<Map<String, dynamic>> readJsonEn(String aboutMeFile) async {
    final jsonData = await rootBundle.loadString(aboutMeFile);
    final Map<String, dynamic> list = json.decode(jsonData);
    var items = list;
    keysEn = items.keys.toList();
    for (int i = 0; i < keysEn.length; i++) {
      var val = items[keysEn[i]];
      // no support right now for nested object notations
      if (val is List) {
        valuesEn.add(val);
      } else if (val == null) {
        valuesEn.add(["not known"]);
      } else {
        valuesEn.add([val]);
      }
    }

    return list;
  }

  // Fetch content from the json file
  Future<Map<String, dynamic>> readJsonDe(String aboutMeFile) async {
    final jsonData = await rootBundle.loadString(aboutMeFile);
    final Map<String, dynamic> list = json.decode(jsonData);
    var items = list;
    keysDe = items.keys.toList();
    for (int i = 0; i < keysDe.length; i++) {
      var val = items[keysDe[i]];
      // no support right now for nested object notations
      if (val is List) {
        valuesDe.add(val);
      } else if (val == null) {
        valuesDe.add(["not known"]);
      } else {
        valuesDe.add([val]);
      }
    }

    return list;
  }

  TextStyle getTextStyle() {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return const TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal); // , color: Colors.black
    } else if (currentWidth <= largeWidthBreakpoint) {
      return const TextStyle(
          fontSize: 22, fontWeight: FontWeight.normal); // , color: Colors.black
    } else {
      return const TextStyle(
          fontSize: 22, fontWeight: FontWeight.normal); // , color: Colors.black
    }
  }

  List<Widget> getSkillTableKeys(dynamic key) {
    // this means string contains sub informations
    if ((key.toString().contains("("))) {
      return <Widget>[
        Text(
          key.substring(0, key.toString().indexOf("(")).trim(),
          style: getTextStyleSubHeadings(context),
        ),
        Text(
          key.substring(key.toString().indexOf("(")).trim(),
          style: getTextStyle(),
        )
      ];
    } else {
      return [
        Text(
          key,
          style: getTextStyleSubHeadings(context),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final double currentWith = MediaQuery.of(context).size.width;
    double betweenColumnPadding =
        (currentWith <= narrowScreenWidthThreshold) ? 40.0 : 80.0;
    const rowDistance = 40.0;
    bool langDeActive = ((Localizations.localeOf(context) == Locale('en') &&
                widget.useOtherLanguageMode) ||
            (Localizations.localeOf(context) == Locale('de')))
        ? true
        : false;

    if (langDeActive) {
      return FutureBuilder(
          future: _readJsonDe,
          builder: (context, data) {
            if (data.hasData) {
              List<TableRow> skills = [];
              for (int i = 0; i < keysDe.length; i++) {
                String entryVal = "";
                var entryList = valuesDe[i];
                for (int j = 0; j < entryList.length; j++) {
                  entryVal += "${"• " + entryList[j]}\n";
                }
                skills.add(TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getSkillTableKeys(keysDe[i]),
                    ),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(betweenColumnPadding, 8, 0, 0),
                    child: Text(entryVal, style: getTextStyle()),
                  ))
                ]));
                skills.add(const TableRow(children: [
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ]));
              }

              return Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  children: skills);
            } else if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    } else {
      return FutureBuilder(
          future: _readJsonEn,
          builder: (context, data) {
            if (data.hasData) {
              List<TableRow> skills = [];
              for (int i = 0; i < keysEn.length; i++) {
                String entryVal = "";
                var entryList = valuesEn[i];
                for (int j = 0; j < entryList.length; j++) {
                  entryVal += "${"• " + entryList[j]}\n";
                }
                skills.add(TableRow(children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getSkillTableKeys(keysEn[i]),
                    ),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(betweenColumnPadding, 8, 0, 0),
                    child: Text(entryVal, style: getTextStyle()),
                  ))
                ]));
                skills.add(const TableRow(children: [
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ]));
              }

              return Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  children: skills);
            } else if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }
  }
}
