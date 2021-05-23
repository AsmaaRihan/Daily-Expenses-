import 'package:beginner_App/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

//map List of Transactions
class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: widget.transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions was added to show',
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\$${widget.transactions[index].amount}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${widget.transactions[index].title}',
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMEd()
                        .format(widget.transactions[index].date)
                        .toString()),
                    trailing: TextButton(
                      onPressed: () =>
                          widget.deleteTx(widget.transactions[index].id)
                      // () {
                      // setState(() {
                      //   widget.transactions.removeAt(index);
                      // });
                      // }
                      ,
                      child: Text('delete'),
                    ),
                  ),
                );
                // return Card(
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
              },
              itemCount: widget.transactions.length,
            ),
    );
  }
}
