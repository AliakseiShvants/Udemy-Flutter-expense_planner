import 'package:expense_planner/entity/transaction.dart';
import 'package:expense_planner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction _transaction;
  final Function _deleteCallback;

  const TransactionItem(this._transaction, this._deleteCallback);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: Constants.CARD_MARGIN,
        horizontal: Constants.CARD_MARGIN,
      ),
      elevation: Constants.CARD_ELEVATION,
      child: ListTile(
        leading: CircleAvatar(
          radius: Constants.CIRCLE_AVATAR,
          child: FittedBox(
            child: Text('\$${_transaction.amount.toStringAsFixed(2)}'),
          ),
        ),
        title: Text(
          _transaction.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Text(
          DateFormat(Constants.DATE_PATTERN).format(_transaction.date),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > Constants.PORTRAIT_SCREEN
            ? FlatButton(
                onPressed: () => _deleteCallback(_transaction.id),
                child: const Text(Constants.DELETE),
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
