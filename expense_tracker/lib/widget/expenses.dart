import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget{

  const Expenses({super.key});

@override
  State<Expenses> createState() {
    return _ExpensesState();
  }

}

class _ExpensesState extends State<Expenses>{

final List<Expense> _registeredExpenses = [
  Expense(title: 'Flutter Course',
  amount: 19.99, 
  date: DateTime.now(), // uses today and now as the data that is stored
  category: Category.work,
  ),
  Expense(title: 'Cinema',
  amount: 15.69, 
  date: DateTime.now(), // uses today and now as the data that is stored
  category: Category.leisure,
  ),
];

@override
  Widget build(BuildContext context) { 
    return Scaffold( // it sends the background of the app to white by default
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: ExpensesList(
            expenses: _registeredExpenses),
          ),

        ],
        ),
    ); 
  
  }

}