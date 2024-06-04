import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {

  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: const [
          TextField( // allowing the user to enter some text
            maxLength: 50,
            keyboardType: TextInputType.text, //this is how we specify for which text is that textField(email, password...)
            decoration: InputDecoration(
              label: Text('Title')
              ),
          ),
        ],
      ),
      );
  }

}