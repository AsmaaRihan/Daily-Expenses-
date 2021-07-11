import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'widget/transaction_list.dart';

import 'package:beginner_App/widget/chart.dart';
import 'package:beginner_App/widget/new_transaction.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);

  runApp(MaterialApp(
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
                title: TextStyle(fontFamily: 'OpenSans', fontSize: 18),
              )),
    ),
    home: Home(),
  ));
}  

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

  bool _showChart = false;
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime _selectedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: _selectedDate);

    setState(() {
      _usertransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((tx) => tx.id == id);
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

  List<Transaction> get _returnTransactionList {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Container txWidgetList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  .7,
              child: Chart(
                _returnTransactionList,
              ),
            )
          : txWidgetList, //table of all the transactions
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Container txWidgetList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            .3,
        child: Chart(
          _returnTransactionList,
        ),
      ),
      txWidgetList
    ];
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAdNewTransactio(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAdNewTransactio(context)),
            ],
          );
    final txWidgetList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          .7,
      child: TransactionList(_usertransaction, _deleteTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, txWidgetList),

            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar,
                  txWidgetList), // (...)  flaters the list to single items
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody, navigationBar: appBar)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAdNewTransactio(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
