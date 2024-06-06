import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(), // uses today and now as the data that is stored
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(), // uses today and now as the data that is stored
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      // a pop up window
      isScrollControlled:
          true, // with this the pop up screen will take all the space
      context: context,
      builder:
          (ctx) => // here we display what happens when the plus button is clicked and user is moved to the next screen
              NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses
        .indexOf(expense); // which index was the expense that was removed

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars(); // which removes any snackBars/info messages we might still have on the screen
    // snackBar is info message shown on the screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // ScaffoldMessenger controls the user interface and shows the certain things on the UI
        duration: const Duration(
            // duration means for how long this snackBar is shown
            seconds: 3),
        content: const Text("Expense deleted."),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            // define the action that should happen if the "Undo" button above is pressed
            setState(() {
              // updates the UI
              _registeredExpenses.insert(
                  // this insert brings back the removed expense by tapping on "Undo"
                  expenseIndex,
                  expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      // if there aren't any expenses shown on the screen this text is shown
      child: Text("No expenses found. Start adding some!"),
    );

    if (_registeredExpenses.isNotEmpty) {
      // if there are just show the expenses as normal by calling the mainContent below in the Column widget
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      // it sends the background of the app to white by default
      appBar: AppBar(
        // to add appbar at the top of the screen
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
