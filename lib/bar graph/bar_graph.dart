import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:control/bar%20graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double segAmount;
  final double terAmount;
  final double quaAmount;
  final double quiAmount;
  final double sexAmount;
  final double sabAmount;
  final double domAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.segAmount,
    required this.terAmount,
    required this.quaAmount,
    required this.quiAmount,
    required this.sexAmount,
    required this.sabAmount,
    required this.domAmount,
  });

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    BarData myBarData = BarData(
      segAmount: segAmount,
      terAmount: terAmount,
      quaAmount: quaAmount,
      quiAmount: quiAmount,
      sexAmount: sexAmount,
      sabAmount: sabAmount,
      domAmount: domAmount,
    );

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.grey[800],
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  Widget text;

  switch (value.toInt()) {
    case 0:
      text = const Text('S', style: style);
      break;
    case 1:
      text = const Text('T', style: style);
      break;
    case 2:
      text = const Text('Q', style: style);
      break;
    case 3:
      text = const Text('Q', style: style);
      break;
    case 4:
      text = const Text('S', style: style);
      break;
    case 5:
      text = const Text('S', style: style);
      break;
    case 6:
      text = const Text('D', style: style);
      break;
    default:
      text = const Text('', style: style);
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
