import 'package:beginner_App/widget/new_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widget/transaction_list.dart';

void main() => runApp(MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          )),
      home: Home(),
    ));

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _usertransaction = [
    // Transaction(id: '1', title: 'Grossary', amount: 50.5, date: DateTime.now()),
    // Transaction(id: '2', title: 'Shopping', amount: 500, date: DateTime.now()),
    // Transaction(id: '3', title: 'SkinCare', amount: 100, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _usertransaction.add(newTx);
    });
  }

  void _startAdNewTransactio(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAdNewTransactio(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue[200],
                child: Text('CHART!'),
                elevation: 50,
              ),
            ),
            TransactionList(_usertransaction), //schudle of all the transactions
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAdNewTransactio(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
