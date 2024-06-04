import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
/* this is one way
//  var _enteredTitle = '';

 // void _saveTitleInput(String inputValue){
 //   _enteredTitle = inputValue;
  //}

  */

  final _titleController =
      TextEditingController(); // creates an object that's optimized for handling the user input
  final _amountController = TextEditingController();
  DateTime? _selectedDate;


  void _presentDatePicker() async {

    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day); // first day to today minus one year

    final pickedDate = await showDatePicker( // await tells flutter to wait for the date that was selected before it stores it in the variable   // it shows a date picker
      context: context,
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now
    );
    setState(() { // this setState waits for for the pickedDate variable
      _selectedDate = pickedDate;
    });
   //   ).then(onValue); // then gets a value of a date which was picked, that is one way of doing this. The alternative is async at the start of the function and then "await"
  }

  // when using this textEditingController dispose method should always be called to dispose of the Controller when not needed
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            // allowing the user to enter some text
            controller: _titleController,
            //         onChanged: _saveTitleInput, //this will be triggered when the value inside this textField
            maxLength: 50,
            keyboardType: TextInputType
                .text, //this is how we specify for which text is that textField(email, password...)
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  // allowing the user to enter some text
                  controller: _amountController,
                  //         onChanged: _saveTitleInput, //this will be triggered when the value inside this textField
                  keyboardType: TextInputType
                      .number, //this is how we specify for which text is that textField(email, password...)
                  decoration: const InputDecoration(
                      prefixText:
                          '\$ ', // this adds a dollar sign to the amount every time the value is entered
                      label: Text('Amount')),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // push the content to the end of the row
                  crossAxisAlignment: CrossAxisAlignment.center, // center the content vertically
                  children: [
                    Text(
                      _selectedDate == null ? 'No date selected' // check if the _selectedDate is null if it is display 'No date selected'
                      : formatter.format(_selectedDate!) // else format the selectedDate and display it instead of 'No date selected'
                    ),
                    IconButton(
                      onPressed: _presentDatePicker, 
                      icon: const Icon(
                        Icons.calendar_month,
                      ))
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context); // Navigator works like an intent(moves from screen to screen), pop. removes this pop-up from the screen
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: () {
                    print(_titleController
                        .text); // contains the text the user entered in the field
                    print(_amountController.text);
                  },
                  child: const Text('Save Expense')),
            ],
          )
        ],
      ),
    );
  }
}
