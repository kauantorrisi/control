import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:control/components/expense_summary.dart';
import 'package:control/components/expense_tile.dart';
import 'package:control/data/expense_data.dart';
import 'package:control/models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController newExpenseNameController =
      TextEditingController();
  final TextEditingController newExpenseRealController =
      TextEditingController();
  final TextEditingController newExpenseCentsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicione uma nova despesa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(hintText: 'Nome da despesa'),
              autofocus: true,
            ),

            // expense amount
            Row(
              children: [
                // real
                Expanded(
                  child: TextField(
                    controller: newExpenseRealController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Real'),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),

                // centavos
                Expanded(
                  child: TextField(
                    controller: newExpenseCentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Centavos'),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancelar'),
          ),

          // save button
          MaterialButton(
            onPressed: save,
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseRealController.text.isNotEmpty &&
        newExpenseCentsController.text.isNotEmpty) {
      // put real and cents together
      String amount =
          '${newExpenseRealController.text}.${newExpenseCentsController.text}';

      // Create expanse item
      ExpenseItem newExpenseItem = ExpenseItem(
        name: newExpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
      );

      // add the new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpenseItem);
    }

    Navigator.pop(context);
    clearControllers();
  }

  void cancel() {
    Navigator.pop(context);
    clearControllers();
  }

  void clearControllers() {
    newExpenseNameController.clear();
    newExpenseRealController.clear();
    newExpenseCentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: ListView(
          children: [
            // weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),

            const SizedBox(height: 20),

            // expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenses().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenses()[index].name,
                amount: value.getAllExpenses()[index].amount,
                dateTime: value.getAllExpenses()[index].dateTime,
                deleteTapped: (p0) =>
                    value.deleteExpense(value.getAllExpenses()[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
