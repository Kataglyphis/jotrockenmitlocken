import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

class SkillTable extends StatefulWidget {
  const SkillTable({super.key, required this.useOtherLanguageMode});
  final bool useOtherLanguageMode;
  @override
  State<SkillTable> createState() => _SkillTableState();
}

class _SkillTableState extends State<SkillTable> {
  _SkillTableState();

  late Future<Map<String, dynamic>> _readJson;
  List keys = [];
  List<List<dynamic>> values = [];
  String aboutMeFileDe = 'assets/data/aboutme_de.json';
  String aboutMeFileEn = 'assets/data/aboutme_en.json';

  void initCsvFuture(BuildContext context) {
    if (Localizations.localeOf(context) == const Locale('de')) {
      _readJson = readJson(aboutMeFileDe);
    } else {
      _readJson = readJson(aboutMeFileEn);
    }
  }

  @override
  initState() {
    super.initState();
    //initCsvFuture(context);
  }

  // Fetch content from the json file
  Future<Map<String, dynamic>> readJson(String aboutMeFile) async {
    final jsonData = await rootBundle.loadString(aboutMeFile);
    final Map<String, dynamic> list = json.decode(jsonData);
    var items = list;
    keys = items.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      var val = items[keys[i]];
      // no support right now for nested object notations
      if (val is List) {
        values.add(val);
      } else if (val == null) {
        values.add(["not known"]);
      } else {
        values.add([val]);
      }
    }

    return list;
  }

  List<Widget> getSkillTableKeys(dynamic key) {
    // this means string contains sub informations
    if ((key.toString().contains("("))) {
      return <Widget>[
        Text(
          key.substring(0, key.toString().indexOf("(")).trim(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          key.substring(key.toString().indexOf("(")).trim(),
          style: Theme.of(context).textTheme.titleMedium,
        )
      ];
    } else {
      return [
        Text(
          key,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final double currentWith = MediaQuery.of(context).size.width;
    double betweenColumnPadding =
        (currentWith <= narrowScreenWidthThreshold) ? 40.0 : 80.0;

    initCsvFuture(context);

    return applyBoxDecoration(
        child: FutureBuilder(
            future: _readJson,
            builder: (context, data) {
              if (data.hasData) {
                List<TableRow> skills = [];
                for (int i = 0; i < keys.length; i++) {
                  String entryVal = "";
                  var entryList = values[i];
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
                        children: getSkillTableKeys(keys[i]),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(betweenColumnPadding, 8, 0, 0),
                      child: Text(entryVal,
                          style: Theme.of(context).textTheme.titleMedium),
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
                final double currentWidth = MediaQuery.of(context).size.width;
                double skillTableWidth = currentWidth;
                if (currentWidth >= mediumWidthBreakpoint) {
                  skillTableWidth = skillTableWidth * 0.4;
                } else {
                  skillTableWidth = skillTableWidth * 0.9;
                }
                return SizedBox(
                  width: skillTableWidth,
                  child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: skills),
                );
              } else if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        color: Theme.of(context).colorScheme.primary);
  }
}
