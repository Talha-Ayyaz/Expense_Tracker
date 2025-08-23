import 'package:expense_tracker/models/expense_item.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  final _myBox = Hive.box('expense_database');


  void saveData(List<ExpenseItem> allExpense) {
    // Convert each expense into a simple list for Hive storage
    List<List<dynamic>> allExpenseFormatted = allExpense.map((expense) {
      return [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
    }).toList();


    _myBox.put('ALL_EXPENSES', allExpenseFormatted);
  }


  List<ExpenseItem> readData() {

    List savedExpenses = _myBox.get('ALL_EXPENSES', defaultValue: []) as List;

    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0] as String;
      String amount = savedExpenses[i][1] as String;
      DateTime dateTime = savedExpenses[i][2] as DateTime;

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      allExpenses.add(expense);
    }

    return allExpenses;
  }
}
