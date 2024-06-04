import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {

  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card( // puts content inside Card with a shadow, it makes it stand out a bit
      
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ), // used for creating margins and paddings
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox( // adds spacings between the text
              height: 4,
            ),
            Row(
              children: [
                // it should take this value as one value that should be injected in toString
                Text('\$${expense.amount.toStringAsFixed(2)}'), // toStringAsFixed ensures that a value 12.3433 is going to be displayed as 12.34 
                const Spacer(), // can be used in any column or row, creates a widget that takes all the space it can get between the other widget its displayed, in this case row will take all the space
                Row( // category and date are grouped so we use row
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}