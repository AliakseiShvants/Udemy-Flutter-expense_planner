import 'package:expense_planner/widget/empty_widget.dart';

import '../entity/transaction.dart';
import './transaction_widget.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatefulWidget {
  final List<Transaction> _transactions;
  final Function _deleteCallback;

  TransactionListWidget(this._transactions, this._deleteCallback);

  @override
  _TransactionListWidgetState createState() =>
      _TransactionListWidgetState(_transactions, _deleteCallback);
}

class _TransactionListWidgetState extends State<TransactionListWidget> {
  final List<Transaction> _transactions;
  final Function _deleteCallback;

  _TransactionListWidgetState(this._transactions, this._deleteCallback);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? EmptyWidget()
        : Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TransactionWidget(_transactions[index], _deleteCallback);
              },
              itemCount: _transactions.length,
            ),
          );
  }
}
