import 'package:expense_tracker/data/database.dart';
import 'package:expense_tracker/dateTime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/cupertino.dart';

class ExpenseData extends ChangeNotifier{

  List<ExpenseItem> overallExpenseList = [];

  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  final db = HiveDatabase();
  void prepareData() {
    final data = db.readData() ?? [];   // if null → fallback to empty list
    if (data.isNotEmpty) {
      overallExpenseList = data;
    }
  }


  void addNewExpense(ExpenseItem expenseItem) {
    overallExpenseList.add(expenseItem);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  String getDayName(DateTime dateTime) {
    switch(dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  Map<String, double> daily_expense() {
    Map<String, double> dailyExpense = {

    };

    for(var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpense.containsKey(date)) {
        double currentAmount = dailyExpense[date]!;
        currentAmount += amount;
        dailyExpense[date] = currentAmount;
      } else {
        dailyExpense.addAll({date: amount});
      }
    }
    return dailyExpense;
  }
}