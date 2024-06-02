import 'package:uuid/uuid.dart';

const uuid = Uuid(); // utility object, which is used to generate an id

enum Category{ // creates a custom type, combination of predefined allowed values
  food,
  travel,
  leisure,
  work
} 
class Expense { // custom class to group all data in a single expense

  Expense({ // named paramaters are used to specify in which order the data should be
    required this.title,
    required this.amount, 
    required this.date,
    required this.category,
    }) : id = uuid.v4(); // generates a unique string id, and its assigned as an initial value to id property 

  final String id; // generating a string id, so that every expense has a unique id
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  

}