import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{

  const Expenses({super.key});

@override
  State<Expenses> createState() {
    return _Expenses();
  }

}

class _Expenses extends State<Expenses>{

@override
  Widget build(BuildContext context) { 
    return const Scaffold( // it sends the background of the app to white by default
      body: Column(
        children: [
          Text('The chart'),
          Text('Expenses list...'),

        ],
        ),
    ); 
  
  }

}