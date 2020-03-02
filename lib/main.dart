import 'package:flutter/material.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: '1', title: 'New keyboard', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: '2', title: 'Groceries', amount: 42.62, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Text('Chart'),
            ),
          ),
          Column(
            children: <Widget>[
              ...transactions.map((transaction) {
                return Card(
                  child: Text(transaction.title),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
