import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Adds new transactions

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    print(enteredTitle);
    print(enteredAmount);
    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        _selectedDate = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'amount'),

              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
              //onChanged: (val) => amountInput = val,
            ),
            Row(
              children: [
                Text(_selectedDate == null
                    ? 'No Data Chosen'
                    : 'Picked Date ${DateFormat.yMd().format(_selectedDate)}'),
                FlatButton(
                    onPressed: _pickDate,
                    child: Text(
                      'Choose Date',
                      style: Theme.of(context).textTheme.title,
                    ))
              ],
            ),
            FlatButton(
                onPressed: submitData,
                child: Text('Add Transacion'),
                textColor: Colors.purple),
          ],
        ),
      ),
    );
  }
}
