import 'package:flutter/material.dart';

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


  void _presentDatePicker(){

    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day); // first day to today minus one year

    showDatePicker( // it shows a date picker
      context: context,
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now
      );
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
                    Text('Selected Date'),
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
