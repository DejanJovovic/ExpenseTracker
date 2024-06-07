import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

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
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
        now.year - 1, now.month, now.day); // first day to today minus one year

    final pickedDate = await showDatePicker(
        // await tells flutter to wait for the date that was selected before it stores it in the variable   // it shows a date picker
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      // this setState waits for for the pickedDate variable
      _selectedDate = pickedDate;
    });
    //   ).then(onValue); // then gets a value of a date which was picked, that is one way of doing this. The alternative is async at the start of the function and then "await"
  }

  void _showDialog() { // finds out on which platfrom we are running, and changes the alert dialog based on the platform
    if (Platform.isIOS) {
      // check if the platfrom of the device is IOS
      showCupertinoDialog(
          // name of the IOS design language/style
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                // for IOS
                title: const Text("Invalid input"),
                content: const Text(
                    "Please make sure a valid title, amount, date and category was enetered."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("Okay"),
                  ),
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure a valid title, amount, date and category was enetered."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    // here we validate the data selected by the user

    // tryParse takes a string and then returns a double if it is enable to return a double
    // if its not able it return null
    // tryParse("Hello") => null, tryParse('1.19') => '1.19'
    final enteredAmount = double.tryParse(_amountController.text);

    // this means that if one of these conditions is false, amountIsInvalid will be true
    // with && both conditions would have to be met to set amountIsInvalid to true
    final amountIsInvalid = enteredAmount == null ||
        enteredAmount <= 0; // && this means AND,  || means OR

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      // if any of these conditions is met, the error will be shown
      return; // if the if conditions is met just show the dialog and do nothinge else
    }

    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!, // ! means that this wont be null for sure
        category: _selectedCategory));

    Navigator.pop(context); // to make sure that the overlay is closed
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
    // build method is called every time the constrains change
    // keyboard space on the screen
    final keyboardSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; // object that contains extra information about ui elementents that might be overlaping ui elements

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        // without this sizedBox the pop up screen that appears when the user wants to add a new expense does not take all the space, and looks better for me
        height: double.infinity, // it takes up as much space as it can get
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >=
                    600) // if the condition is met, there is no need for curly braces
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: TextField(
                        // allowing the user to enter some text
                        controller: _titleController,
                        //         onChanged: _saveTitleInput, //this will be triggered when the value inside this textField
                        maxLength: 50,
                        keyboardType: TextInputType
                            .text, //this is how we specify for which text is that textField(email, password...)
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
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
                  ])
                else // else this runs
                  TextField(
                    // allowing the user to enter some text
                    controller: _titleController,
                    //         onChanged: _saveTitleInput, //this will be triggered when the value inside this textField
                    maxLength: 50,
                    keyboardType: TextInputType
                        .text, //this is how we specify for which text is that textField(email, password...)
                    decoration: const InputDecoration(label: Text('Title')),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          // map transforms from one value to another
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value:
                                      category, // this value is stored internally
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // push the content to the end of the row
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // center the content vertically
                          children: [
                            Text(_selectedDate == null
                                    ? 'No date selected' // check if the _selectedDate is null if it is display 'No date selected'
                                    : formatter.format(
                                        _selectedDate!) // else format the selectedDate and display it instead of 'No date selected'
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
                  )
                else
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // push the content to the end of the row
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // center the content vertically
                          children: [
                            Text(_selectedDate == null
                                    ? 'No date selected' // check if the _selectedDate is null if it is display 'No date selected'
                                    : formatter.format(
                                        _selectedDate!) // else format the selectedDate and display it instead of 'No date selected'
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
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // Navigator works like an intent(moves from screen to screen), pop. removes this pop-up from the screen
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense')),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          // map transforms from one value to another
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value:
                                      category, // this value is stored internally
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // Navigator works like an intent(moves from screen to screen), pop. removes this pop-up from the screen
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense')),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
