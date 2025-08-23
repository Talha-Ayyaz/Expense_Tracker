import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final nameController = TextEditingController();
  final ruppeeController = TextEditingController();
  final paisaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add new expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Expense Name'
                ),
              ),
             Row(
               children: [
                 Expanded(
                   child: TextField(
                     controller: ruppeeController,
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                       hintText: 'Rupees'
                     ),
                   ),
                 ),
                 Expanded(
                   child: TextField(
                     controller: paisaController,
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                       hintText: 'Paisa'
                     ),
                   ),
                 )
               ],
             )
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: save,
              child: Text('Save'),
            ),
            MaterialButton(
              onPressed: cancel,
              child: Text('Cancel'),
            )
          ],
        )
    );
  }

void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
}
void save() {

    if(nameController.text.isNotEmpty && ruppeeController.text.isNotEmpty && paisaController.text.isNotEmpty) {
      String amount = '${ruppeeController.text}.${paisaController.text}';
      ExpenseItem newExpense = ExpenseItem(
          name: nameController.text,
          amount: amount,
          dateTime: DateTime.now()
      );
      Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
}

void cancel() {
    Navigator.pop(context);
}

void clear() {
    nameController.clear();
    ruppeeController.clear();
    paisaController.clear();
}

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData> (
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white,),
        ),
        body: ListView(
            children: [
              ExpenseSummary(startOfWeek: value.startOfWeekDate()),

              const SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: (context, index) => ExpenseTile(
                      name: value.getAllExpenseList()[index].name,
                      amount: value.getAllExpenseList()[index].amount,
                      dateTime: value.getAllExpenseList()[index].dateTime,
                      deleteTapped: (p0) => deleteExpense(value.getAllExpenseList()[index]),
                  )
              )
            ],
        ),
      ),
    );
  }
}