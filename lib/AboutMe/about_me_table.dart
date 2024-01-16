import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/AboutMe/donation.dart';
import 'package:jotrockenmitlocken/AboutMe/socialMedia/social_media_widgets.dart';
import 'package:jotrockenmitlocken/Charts/pie_chart_data_entry.dart';
import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'skill_table.dart';

class AboutMeTable extends StatefulWidget {
  const AboutMeTable({
    Key? key,
  }) : super(key: key); //required this.colorSelected

  //final ColorSeed colorSelected;
  @override
  AboutMeTableState createState() =>
      AboutMeTableState(); //colorSelected: colorSelected
}

class AboutMeTableState extends State<AboutMeTable> {
  AboutMeTableState({
    Key? key,
  });
  //required this.colorSelected,

  //final ColorSeed colorSelected;

  @override
  void initState() {
    super.initState();
  }

  TextStyle getTextStyle() {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return const TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal); //, color: Colors.black
    } else if (currentWidth <= largeWidthBreakpoint) {
      return const TextStyle(
          fontSize: 22, fontWeight: FontWeight.normal); //, color: Colors.black
    } else {
      return const TextStyle(
          fontSize: 22, fontWeight: FontWeight.normal); //, color: Colors.black
    }
  }

  double getDayHourPercantage(double houresPerDay) {
    double n = (houresPerDay / 24) * 100;
    return double.parse(n.toStringAsFixed(2));
  }

  Widget createMyPerfectDayPieChart() {
    final List<PieChartDataEntry> chartData = [
      PieChartDataEntry('Sleep', getDayHourPercantage(8)),
      PieChartDataEntry('Studying', getDayHourPercantage(8)),
      PieChartDataEntry('Sports', getDayHourPercantage(2)),
      PieChartDataEntry('Meditation', getDayHourPercantage(1)),
      PieChartDataEntry('Guitar', getDayHourPercantage(1)),
      PieChartDataEntry('Family&Friends', getDayHourPercantage(4))
    ];
    final double currentWith = MediaQuery.of(context).size.width;
    final bool enableSkillTableLegend =
        (currentWith >= narrowScreenWidthThreshold) ? false : true;
    // https://help.syncfusion.com/flutter/circular-charts/overview
    return SfCircularChart(
      title: ChartTitle(
          text: 'My perfect day', textStyle: getTextStyleHeadings(context)),
      legend: Legend(
          width: '100%',
          overflowMode: LegendItemOverflowMode.wrap,
          isVisible: enableSkillTableLegend,
          textStyle: getTextStyle(),
          position: LegendPosition.bottom),
      series: <CircularSeries>[
        // Render pie chart
        DoughnutSeries<PieChartDataEntry, String>(
            dataSource: chartData,
            xValueMapper: (PieChartDataEntry data, _) => data.x,
            yValueMapper: (PieChartDataEntry data, _) => data.y,
            dataLabelMapper: (PieChartDataEntry data, _) => data.x,
            // Explode the segments on tap
            animationDuration: 1000,
            animationDelay: 2000,
            explode: true,
            explodeIndex: 5,
            radius: (MediaQuery.of(context).size.width >=
                    narrowScreenWidthThreshold)
                ? '80%'
                : '80%',
            innerRadius: '30%',
            dataLabelSettings: DataLabelSettings(
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: getTextStyle(),
              isVisible: !enableSkillTableLegend,
              labelIntersectAction: LabelIntersectAction.shift,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double currentWidth = MediaQuery.of(context).size.width;
    // init all as it would be rendered on phone
    double picWidth = currentWidth * 0.9;
    double skillTableWidth = currentWidth;
    double marginPic = 0;
    double paddingPic = 0;
    const double borderRadiusPic = 10;
    double marginSkillTable = 10;
    double paddingSkillTable = 5;
    if (currentWidth >= narrowScreenWidthThreshold &&
        currentWidth <= largeWidthBreakpoint) {
      picWidth = currentWidth * 0.6;
      skillTableWidth = currentWidth * 0.8;
      marginPic = 0;
      paddingPic = 0;
      marginSkillTable = 20;
      paddingSkillTable = 20;
    } else if (currentWidth >= largeWidthBreakpoint) {
      picWidth = currentWidth * 0.4;
      skillTableWidth = currentWidth * 0.5;
      marginPic = 0;
      paddingPic = 0;
      marginSkillTable = 20;
      paddingSkillTable = 20;
    }
    Color selectedColor = Theme.of(context).primaryColor;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: getpagesSpacingToTop(context)),
          SizedBox(
            width: picWidth,
            child: applyBoxDecoration(
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: const FadeInImage(
                    placeholder: AssetImage(
                        "assets/images/Bewerbungsbilder/a95a64ca-min.jpg"),
                    image: AssetImage(
                      "assets/images/Bewerbungsbilder/a95a64ca.jpg",
                    ),
                  ),
                ),
                EdgeInsets.all(paddingPic),
                marginPic,
                borderRadiusPic,
                10,
                selectedColor),
          ),
          const SizedBox(height: 30),
          Text(
            "Jonas Heinle",
            textAlign: TextAlign.center,
            style: getTextStyleHeadings(context),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: skillTableWidth,
            child: Text(
              "»As soon as it works, no-one calls it AI anymore.« (John McCarthy)\n\n I study computer science at the Karlsruhe Institute of Technology, where I major in Computer Graphics, Geometry Processing, Anthropomatics and Cognitive Systems with a specific interest in deep learning.",
              textAlign: TextAlign.center,
              style: getTextStyle(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
              onPressed: () async {
                String email =
                    Uri.encodeComponent("cataglyphis@jotrockenmitlocken.de");
                String subject = Uri.encodeComponent("Awesome job offer");
                String body = Uri.encodeComponent("Hi Jonas");
                //print(subject); //output: Hello%20Flutter
                Uri mail =
                    Uri.parse("mailto:$email?subject=$subject&body=$body");
                if (await launchUrl(mail)) {
                  //email app opened
                } else {
                  //email app is not opened
                }
              },
              child: const Text(
                "Mail Me Now",
                //style: //TextStyle(
                //fontWeight: FontWeight.bold,
                //color: Colors.black,
                //fontSize: 20)
              )),
          const SizedBox(height: 30),
          Text(
            "cataglyphis@jotrockenmitlocken.de",
            textAlign: TextAlign.center,
            style: getTextStyleHeadings(context),
          ),
          const SizedBox(height: 30),
          const SocialMediaWidgets(),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: skillTableWidth,
            child: applyBoxDecoration(
                const SkillTable(),
                EdgeInsets.all(paddingSkillTable),
                marginSkillTable,
                30,
                10,
                selectedColor),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(height: 500, child: createMyPerfectDayPieChart()),
          const SizedBox(
            height: 50,
          ),
          Donation(getTextStyleHeadings(context)),
          const SizedBox(
            height: 50,
          ),
          Text(
            "I love to cURL",
            textAlign: TextAlign.center,
            style: getTextStyleHeadings(context),
          ),
          IconButton(
            iconSize: 40,
            icon: const FaIcon(FontAwesomeIcons.dumbbell),
            // color: Colors.black,
            onPressed: () {},
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Let's talk about the Pumping Lemma.",
            textAlign: TextAlign.center,
            style: getTextStyleHeadings(context),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      );
    });
  }
}
