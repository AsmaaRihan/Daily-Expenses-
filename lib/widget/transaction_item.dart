import 'dart:math';

import 'package:flutter/material.dart';

import 'package:beginner_App/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const availableColor = [
      Colors.green,
      Colors.blueAccent,
      Colors.red,
      Colors.purple,
      Colors.blue
    ];

    _bgColor = availableColor[Random().nextInt(5)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor, //Theme.of(context).primaryColor,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$${widget.transaction.amount}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          '${widget.transaction.title}',
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
            DateFormat.yMMMEd().format(widget.transaction.date).toString()),
        trailing: TextButton(
          onPressed: () => widget.deleteTx(widget.transaction.id)
          // () {
          // setState(() {
          //     transaction.removeAt(index);
          // });
          // }
          ,
          child: Text('delete'),
        ),
      ),
    );
  }
}
