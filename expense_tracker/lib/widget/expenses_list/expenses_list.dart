import 'package:expense_tracker/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget{

  const ExpensesList({
    super.key,
    required this.expenses,
    }); 

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder( // scrollable list and build create items only when they are visible
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => // immediately define the value that should be returned
      ExpenseItem(expenses[index])
    );
  }

}