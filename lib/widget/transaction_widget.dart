import 'package:expense_planner/entity/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction _transaction;
  final Function _deleteCallback;

  TransactionWidget(this._transaction, this._deleteCallback);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 4,
      ),
      elevation: 8,
      child: ListTile(
        leading: CircleAvatar(
          radius: 32,
          child: FittedBox(
            child: Text('\$${_transaction.amount.toStringAsFixed(2)}'),
          ),
        ),
        title: Text(
          _transaction.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Text(
          DateFormat('dd MMM yyyy HH:mm').format(_transaction.date),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton(
                onPressed: () => _deleteCallback(_transaction.id),
                child: Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => _deleteCallback(_transaction.id),
              ),
      ),
    );
  }
}
