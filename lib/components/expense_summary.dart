import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:control/bar%20graph/bar_graph.dart';
import 'package:control/data/expense_data.dart';
import 'package:control/datetime/date_time_helper.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculateMaxY(
    ExpenseData value,
    String segunda,
    String terca,
    String quarta,
    String quinta,
    String sexta,
    String sabado,
    String domingo,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[segunda] ?? 0,
      value.calculateDailyExpenseSummary()[terca] ?? 0,
      value.calculateDailyExpenseSummary()[quarta] ?? 0,
      value.calculateDailyExpenseSummary()[quinta] ?? 0,
      value.calculateDailyExpenseSummary()[sexta] ?? 0,
      value.calculateDailyExpenseSummary()[sabado] ?? 0,
      value.calculateDailyExpenseSummary()[domingo] ?? 0,
    ];

    values.sort();

    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpenseData value,
    String segunda,
    String terca,
    String quarta,
    String quinta,
    String sexta,
    String sabado,
    String domingo,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[segunda] ?? 0,
      value.calculateDailyExpenseSummary()[terca] ?? 0,
      value.calculateDailyExpenseSummary()[quarta] ?? 0,
      value.calculateDailyExpenseSummary()[quinta] ?? 0,
      value.calculateDailyExpenseSummary()[sexta] ?? 0,
      value.calculateDailyExpenseSummary()[sabado] ?? 0,
      value.calculateDailyExpenseSummary()[domingo] ?? 0,
    ];

    double total = 0;
    for (var i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    // get ddmmyyyy for eaach day of this week
    String domingo =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String segunda =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String terca =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String quarta =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String quinta =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String sexta =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sabado =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          // week total
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                const Text(
                  'Total da semana: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'R\$${calculateWeekTotal(value, segunda, terca, quarta, quinta, sexta, sabado, domingo)}',
                ),
              ],
            ),
          ),

          // bar graph
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMaxY(value, segunda, terca, quarta, quinta, sexta,
                  sabado, domingo),
              segAmount: value.calculateDailyExpenseSummary()[segunda] ?? 0,
              terAmount: value.calculateDailyExpenseSummary()[terca] ?? 0,
              quaAmount: value.calculateDailyExpenseSummary()[quarta] ?? 0,
              quiAmount: value.calculateDailyExpenseSummary()[quinta] ?? 0,
              sexAmount: value.calculateDailyExpenseSummary()[sexta] ?? 0,
              sabAmount: value.calculateDailyExpenseSummary()[sabado] ?? 0,
              domAmount: value.calculateDailyExpenseSummary()[domingo] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
