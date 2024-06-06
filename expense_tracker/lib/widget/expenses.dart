import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';
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


void _openAddExpenseOverlay(){
  showModalBottomSheet( // a pop up window
    isScrollControlled: true, // with this the pop up screen will take all the space
    context: context,
    builder: (ctx) => // here we display what happens when the plus button is clicked and user is moved to the next screen
      NewExpense(onAddExpense: _addExpense),
    );
}

void _addExpense(Expense expense){

  setState(() {
    _registeredExpenses.add(expense);
  });
  
}


@override
  Widget build(BuildContext context) { 
    return Scaffold( // it sends the background of the app to white by default
      appBar: AppBar( // to add appbar at the top of the screen
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, 
            icon: const Icon(Icons.add))
        ],
      ),
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