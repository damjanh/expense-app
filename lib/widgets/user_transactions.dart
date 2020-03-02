import 'package:flutter/material.dart';

import '../model/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
