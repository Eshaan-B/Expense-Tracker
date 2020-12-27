import 'package:flutter/material.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.mediaQuery,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child: Text(
                  '\$${transaction.amount}',
                )),
          ),
        ),
        title: Text(
          '${transaction.title}',
          style: Theme
              .of(context)
              .textTheme
              .headline6,
        ),
        subtitle: Text(
            '${DateFormat.yMMMd().format(transaction.date)}'),
        trailing: mediaQuery
            .size
            .width > 400
            ? FlatButton.icon(
          icon: Icon(Icons.delete),
          label: const Text('Delete'),
          textColor: Theme
              .of(context)
              .errorColor,
          onPressed: () {
            deleteTransaction(transaction.id);
          },
        )
            : IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme
                .of(context)
                .errorColor,
          ),
          onPressed: () {
            deleteTransaction(transaction.id);
          },
        ),
      ),
    );
  }
}