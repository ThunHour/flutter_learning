import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:persional_expens/widget/chart.dart';
import 'package:persional_expens/widget/new_trnsaction.dart';
import 'package:persional_expens/widget/transaction_list.dart';
import 'model/transaction.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'Opensan',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  titleLarge: TextStyle(
                    fontFamily: 'Opensan',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final List<Transaction> _transactionsList = [
    Transaction(
      id: 't1',
      title: 'New IPhone 13 pro max',
      amount: 1300,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Air port',
      amount: 200,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'box',
      amount: 1,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'case',
      amount: 4,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'keybard',
      amount: 30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'New IPhone 13 pro max',
      amount: 1300,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'New IPhone 13 pro max',
      amount: 1300,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'New IPhone 13 pro max',
      amount: 1300,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'New IPhone 13 pro max',
      amount: 1300,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'New IPhone 13 pro max',
      amount: 1300,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'New IPhone 13 pro max',
      amount: 1300,
      date: DateTime.now(),
    ),
  ];
  void _addNewTransactions(String txTitle, double txAmount) {

    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      _transactionsList.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactionsList.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  // return tx.date.isAfter(DateTime.now().subtract(Duration(days:7)));
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.redAccent,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransactions),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Persional Expenses', style: TextStyle(fontFamily: 'Opensan')),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactionsList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
