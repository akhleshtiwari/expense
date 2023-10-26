//import 'package:expense_tracker/widget/expenses/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

import 'expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'flutter all course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3), content: Text("Expense Deleted")));
  }

  void _openaddexpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExppense: addExpense,
            ));
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent =
        const Center(child: Text("expense is empty plzz add some expenses"));

    if (_registeredExpenses.isNotEmpty) {
      maincontent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(" Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _openaddexpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [const Text('chart'), Expanded(child: maincontent)],
      ),
    );
  }
}
