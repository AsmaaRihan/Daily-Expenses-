import 'package:beginner_App/models/transaction.dart';
import 'package:beginner_App/widget/transaction_item.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

//map List of Transactions
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    'No Transactions was added to show',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView(
              children: transactions
                  .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTx: deleteTx))
                  .toList() // : ListView.builder(
              //     itemBuilder: (ctx, index) {
              //       return TransactionItem(
              //           transaction: transactions[index], deleteTx: deleteTx);
              //       // return Card(
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin:
              //             EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Colors.black,
              //             width: 3,
              //           ),
              //         ),
              //         padding: EdgeInsets.all(5),
              //         child: Text(
              //           '\$${transactions[index].amount}',
              //           style: TextStyle(fontWeight: FontWeight.bold),
              //         ),
              //       ),

              //       // Column(
              //       //   crossAxisAlignment: CrossAxisAlignment.start,
              //       //   children: <Widget>[
              //       //     Text(
              //       //       transactions[index].title,
              //       //       style: TextStyle(
              //       //           color: Colors.purple,
              //       //           fontWeight: FontWeight.bold),
              //       //     ),
              //       //     Text(
              //       //         DateFormat.yMMMd()
              //       //             .format(transactions[index].date),
              //       //         style:
              //       //             TextStyle(color: Colors.grey, fontSize: 10)),
              //       //   ],
              //       // ),
              //     ],
              //   ),
              // );
              // },
              // itemCount: transactions.length,
              ),
    );
  }
}
