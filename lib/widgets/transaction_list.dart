import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? FlatButton.icon(
                            onPressed: () =>
                                deleteTransaction(transactions[index].id),
                            textColor: Theme.of(context).errorColor,
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'))
                        : IconButton(
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () =>
                                deleteTransaction(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
