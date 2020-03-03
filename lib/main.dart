import 'dart:io';

import 'package:expenseapp/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.purpleAccent,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData
            .light()
            .textTheme
            .copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
  bool _showChart = false;
  final List<Transaction> _transactions = [
    Transaction(
        id: '1', title: 'New keyboard', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: '2', title: 'Groceries', amount: 42.62, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) =>
        element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _openNewTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle: Text('Expense Tracker'),
      trailing: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GestureDetector(
            child: Icon(_showChart ? Icons.view_list : Icons.show_chart),
            onTap: () {
              setState(() {
                _showChart = !_showChart;
              });
            },),
          GestureDetector(child: Icon(CupertinoIcons.add),
            onTap: () => _openNewTransactionModal(context),)
        ],),
    )
        : AppBar(
      title: Text('Expense Tracker'),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
            icon: Icon(
              _showChart ? Icons.view_list : Icons.show_chart,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _openNewTransactionModal(context),
        )
      ],
    );

    final transactionsList = Container(
      height: (MediaQuery
          .of(context)
          .size
          .height -
          appBar.preferredSize.height -
          mediaQuery
              .padding
              .top) *
          (isLandscape ? 0.9 : 1),
      child: TransactionList(_transactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (isLandscape)
                Container(
                  height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                      0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Show Chart',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Switch.adaptive(
                        activeColor: Theme
                            .of(context)
                            .accentColor,
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              if (!isLandscape)
                Container(
                  height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions),
                ),
              if (!isLandscape) transactionsList,
              if (isLandscape)
                _showChart
                    ? Container(
                  height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                      0.5,
                  child: Chart(_recentTransactions),
                )
                    : transactionsList,
            ],
          ),
        )
    );

    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody, navigationBar: appBar,) : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _openNewTransactionModal(context),
      ),
    );
  }
}
