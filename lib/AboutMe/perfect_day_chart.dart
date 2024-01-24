import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Charts/pie_chart_data_entry.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PerfectDay extends StatefulWidget {
  @override
  PerfectDayState createState() => PerfectDayState();
}

class PerfectDayState extends State {
  static double getDayHourPercantage(double houresPerDay) {
    double n = (houresPerDay / 24) * 100;
    return double.parse(n.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final List<PieChartDataEntry> chartData = [
      PieChartDataEntry(
          AppLocalizations.of(context)!.sleep, getDayHourPercantage(8)),
      PieChartDataEntry(
          AppLocalizations.of(context)!.studying, getDayHourPercantage(8)),
      PieChartDataEntry(
          AppLocalizations.of(context)!.sports, getDayHourPercantage(2)),
      PieChartDataEntry(
          AppLocalizations.of(context)!.meditation, getDayHourPercantage(1)),
      PieChartDataEntry(
          AppLocalizations.of(context)!.guitar, getDayHourPercantage(1)),
      PieChartDataEntry(
          AppLocalizations.of(context)!.familyFriends, getDayHourPercantage(4))
    ];
    final double currentWith = MediaQuery.of(context).size.width;
    final bool enableSkillTableLegend =
        (currentWith >= narrowScreenWidthThreshold) ? false : true;
    // https://help.syncfusion.com/flutter/circular-charts/overview
    return SfCircularChart(
      title: ChartTitle(
          text: AppLocalizations.of(context)!.myPerfectDay,
          textStyle: FontHelper.getTextStyleHeadings(context)),
      legend: Legend(
          width: '100%',
          overflowMode: LegendItemOverflowMode.wrap,
          isVisible: enableSkillTableLegend,
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
            animationDelay: 500,
            explode: true,
            explodeIndex: 5,
            radius: (MediaQuery.of(context).size.width >=
                    narrowScreenWidthThreshold)
                ? '80%'
                : '80%',
            innerRadius: '20%',
            dataLabelSettings: DataLabelSettings(
              textStyle: FontHelper.getTextStyle(context),
              labelPosition: ChartDataLabelPosition.outside,
              isVisible: !enableSkillTableLegend,
              labelIntersectAction: LabelIntersectAction.shift,
            )),
      ],
    );
  }
}
  // static Widget createMyPerfectDayPieChart(BuildContext context) {
  //   final List<PieChartDataEntry> chartData = [
  //     PieChartDataEntry(
  //         AppLocalizations.of(context)!.sleep, getDayHourPercantage(8)),
  //     PieChartDataEntry(
  //         AppLocalizations.of(context)!.studying, getDayHourPercantage(8)),
  //     PieChartDataEntry(
  //         AppLocalizations.of(context)!.sports, getDayHourPercantage(2)),
  //     PieChartDataEntry(
  //         AppLocalizations.of(context)!.meditation, getDayHourPercantage(1)),
  //     PieChartDataEntry(
  //         AppLocalizations.of(context)!.guitar, getDayHourPercantage(1)),
  //     PieChartDataEntry(
  //         AppLocalizations.of(context)!.familyFriends, getDayHourPercantage(4))
  //   ];
  //   final double currentWith = MediaQuery.of(context).size.width;
  //   final bool enableSkillTableLegend =
  //       (currentWith >= narrowScreenWidthThreshold) ? false : true;
  //   // https://help.syncfusion.com/flutter/circular-charts/overview
  //   return SfCircularChart(
  //     title: ChartTitle(
  //         text: AppLocalizations.of(context)!.myPerfectDay,
  //         textStyle: FontHelper.getTextStyleHeadings(context)),
  //     legend: Legend(
  //         width: '100%',
  //         overflowMode: LegendItemOverflowMode.wrap,
  //         isVisible: enableSkillTableLegend,
  //         position: LegendPosition.bottom),
  //     series: <CircularSeries>[
  //       // Render pie chart
  //       DoughnutSeries<PieChartDataEntry, String>(
  //           dataSource: chartData,
  //           xValueMapper: (PieChartDataEntry data, _) => data.x,
  //           yValueMapper: (PieChartDataEntry data, _) => data.y,
  //           dataLabelMapper: (PieChartDataEntry data, _) => data.x,
  //           // Explode the segments on tap
  //           animationDuration: 1000,
  //           animationDelay: 500,
  //           explode: true,
  //           explodeIndex: 5,
  //           radius: (MediaQuery.of(context).size.width >=
  //                   narrowScreenWidthThreshold)
  //               ? '80%'
  //               : '80%',
  //           innerRadius: '20%',
  //           dataLabelSettings: DataLabelSettings(
  //             textStyle: FontHelper.getTextStyle(context),
  //             labelPosition: ChartDataLabelPosition.outside,
  //             isVisible: !enableSkillTableLegend,
  //             labelIntersectAction: LabelIntersectAction.shift,
  //           )),
  //     ],
  //   );
  // }

