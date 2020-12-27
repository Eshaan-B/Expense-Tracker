import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction}) {
    print('Construstor NewTransaction widget');
  }

  @override
  _NewTransactionState createState() {
    print('Created State');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  _NewTransactionState(){
    print('State constructor called');
  }
  @override
  void initState() {
    // TODO: implement initState
    print('initState()');
    super.initState();
  }
  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose()');
    super.dispose();
  }
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    String enteredTitle = _titleController.text;
    double enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;
    _titleController.clear();
    _amountController.clear();
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No data chosen'
                          : 'Picked Date : ${DateFormat.yMMMd().format(
                          _selectedDate)}'),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                        : FlatButton(
                      textColor: Theme
                          .of(context)
                          .primaryColor,
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme
                    .of(context)
                    .primaryColor,
                child: Text('Add transaction'),
                textColor: Theme
                    .of(context)
                    .textTheme
                    .button
                    .color,
                onPressed: () {
                  _submitData();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
