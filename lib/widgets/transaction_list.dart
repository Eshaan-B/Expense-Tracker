import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Text(
            'No transactions added yet!',
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset('assets/images/waiting.png'))
        ],
      );
    })
        : ListView.builder(
      itemBuilder: (context, index) {
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
                      '\$${transactions[index].amount}',
                    )),
              ),
            ),
            title: Text(
              '${transactions[index].title}',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
            subtitle: Text(
                '${DateFormat.yMMMd().format(transactions[index].date)}'),
            trailing: mediaQuery
                .size
                .width > 400
                ? FlatButton.icon(
                icon: Icon(Icons.delete),
              label: const Text('Delete'),
              textColor: Theme.of(context).errorColor,
              onPressed: () {
                deleteTransaction(transactions[index].id);
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
                deleteTransaction(transactions[index].id);
              },
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
