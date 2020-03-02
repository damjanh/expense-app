import 'package:expenseapp/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'widgets/new_transaction.dart';
import 'model/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<Transaction> _transactions = [
    Transaction(
        id: '1', title: 'New keyboard', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: '2', title: 'Groceries', amount: 42.62, date: DateTime.now())
  ];

  void _addNewTransaction(String title, double amount) {
    final now = DateTime.now();
    final newTransaction = Transaction(
        id: now.toString(), title: title, amount: amount, date: now);

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _openNewTransactionModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (builderContext) {
      return NewTransaction(_addNewTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _openNewTransactionModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text('Chart'),
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        onPressed: () => _openNewTransactionModal(context),
      ),
    );
  }
}
