import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat
    .yMd(); // creates a formatted object, yMd defines how the date will be formatted

const uuid = Uuid(); // utility object, which is used to generate an id

enum Category {
  // creates a custom type, combination of predefined allowed values
  food,
  travel,
  leisure,
  work
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  // custom class to group all data in a single expense

  Expense({
    // named paramaters are used to specify in which order the data should be
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); // generates a unique string id, and its assigned as an initial value to id property

  final String
      id; // generating a string id, so that every expense has a unique id
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  // this class defines a group of expenses

  const ExpenseBucket({required this.category, required this.expenses});

  // go through all expenses and get the expenses for every category
  ExpenseBucket.forCategory(List<Expense> allExpenses,
      this.category) // this is how we add additional constructor functions to classes
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); // where allows to filter a list, takes a function as an argument
  // if the expense category has the category i wanna set for this expenseBucket i want to keep that expense
  
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    // for( var i = 0; i < expenses.lenght; i++) instead of this we do this below, using the for in
    for (final expense in expenses) {
      // we go through the list expenses
      sum += expense.amount;
    } // summs up all the expenses in the expense list and returns a sum as a number

    return sum;
  }
}
