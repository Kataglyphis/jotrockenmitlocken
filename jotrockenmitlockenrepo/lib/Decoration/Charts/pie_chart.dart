import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Decoration/Charts/pie_chart_data_entry.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  const PieChart(
      {super.key,
      required this.chartConfig,
      required this.title,
      this.animate = true});
  final Map<String, double> chartConfig;
  final String title;
  final bool animate;
  @override
  PieChartState createState() => PieChartState();
}

class PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    final List<PieChartDataEntry> chartData = [];
    widget.chartConfig.forEach((entryName, valueInPercentage) {
      chartData.add(PieChartDataEntry(entryName, valueInPercentage));
    });

    final double currentWith = MediaQuery.of(context).size.width;
    final bool enableSkillTableLegend =
        (currentWith >= narrowScreenWidthThreshold) ? false : true;
    // https://help.syncfusion.com/flutter/circular-charts/overview
    return SfCircularChart(
      title: ChartTitle(
          text: widget.title,
          textStyle: Theme.of(context).textTheme.headlineLarge),
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
            animationDuration: (widget.animate) ? 1000 : 0,
            animationDelay: 500,
            explode: true,
            explodeIndex: 5,
            radius: (MediaQuery.of(context).size.width >=
                    narrowScreenWidthThreshold)
                ? '80%'
                : '80%',
            innerRadius: '20%',
            dataLabelSettings: DataLabelSettings(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              labelPosition: ChartDataLabelPosition.outside,
              isVisible: !enableSkillTableLegend,
              labelIntersectAction: LabelIntersectAction.shift,
            )),
      ],
    );
  }
}
