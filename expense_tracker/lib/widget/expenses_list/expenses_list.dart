import 'package:expense_tracker/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // scrollable list and build create items only when they are visible
      itemCount: expenses.length,
      // immediately define the value that should be returned
      itemBuilder: (ctx, index) => Dismissible(
          // allows the user to dismiss the expense by swiping away
          key: ValueKey(// creates a key object that can be used as key value
              expenses[index]),
          background: Container( // shown when the user tries to swipe away the expense
            color: Theme.of(context).colorScheme.error.withOpacity(0.75), // gives slightly transparent color vibe,
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal
            ),
          ),
          onDismissed: (direction) // this is what happens when the expense is dismissed or swiped away
            { 
          onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index])),
    );
  }
}
