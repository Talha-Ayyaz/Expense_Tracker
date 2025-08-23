import 'package:expense_tracker/barGraph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/dateTime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });


  double calculateMax(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      ) {
    List<double> values = [
      value.daily_expense()[sunday] ?? 0,
      value.daily_expense()[monday] ?? 0,
      value.daily_expense()[tuesday] ?? 0,
      value.daily_expense()[wednesday] ?? 0,
      value.daily_expense()[thursday] ?? 0,
      value.daily_expense()[friday] ?? 0,
      value.daily_expense()[saturday] ?? 0,
    ];

    double highest = values.reduce((a, b) => a > b ? a : b);
    return highest == 0 ? 100 : highest * 1.1;
  }


  String calculateWeekTotal(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      ) {
    List<double> values = [
      value.daily_expense()[sunday] ?? 0,
      value.daily_expense()[monday] ?? 0,
      value.daily_expense()[tuesday] ?? 0,
      value.daily_expense()[wednesday] ?? 0,
      value.daily_expense()[thursday] ?? 0,
      value.daily_expense()[friday] ?? 0,
      value.daily_expense()[saturday] ?? 0,
    ];

    double total = values.fold(0, (sum, v) => sum + v);
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
    convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
    convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
    convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
    convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
    convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
    convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
    convertDateTimeToString(startOfWeek.add(const Duration(days: 6))); // ✅ fixed

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          // Week total
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                const Text('Week Total: '),
                Text(
                  'Rs. ${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',
                ),
              ],
            ),
          ),

          // Bar chart
          SizedBox(
            height: 200,
            child: BarGraph(
              maxY: calculateMax(
                value,
                sunday,
                monday,
                tuesday,
                wednesday,
                thursday,
                friday,
                saturday,
              ),
              sunAmount: value.daily_expense()[sunday] ?? 0,
              monAmount: value.daily_expense()[monday] ?? 0,
              tueAmount: value.daily_expense()[tuesday] ?? 0,
              wedAmount: value.daily_expense()[wednesday] ?? 0,
              thurAmount: value.daily_expense()[thursday] ?? 0,
              friAmount: value.daily_expense()[friday] ?? 0,
              satAmount: value.daily_expense()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
