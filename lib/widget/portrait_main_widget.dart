import 'package:expense_planner/entity/transaction.dart';
import 'package:flutter/material.dart';
import 'chart_widget.dart';
import 'transaction_list_widget.dart';

class PortraitMainWidget extends StatelessWidget {
  final AppBar _appBar;
  final List<Transaction> _recentTransactions;
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  PortraitMainWidget(this._appBar, this._recentTransactions, this._transactions,
      this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: (MediaQuery
              .of(context)
              .size
              .height -
              _appBar.preferredSize.height -
              MediaQuery
                  .of(context)
                  .padding
                  .top) *
              0.3,
          child: ChartWidget(_recentTransactions),
        ),
        Container(
          height: (MediaQuery
              .of(context)
              .size
              .height -
              _appBar.preferredSize.height -
              MediaQuery
                  .of(context)
                  .padding
                  .top) *
              0.7,
          child: TransactionListWidget(_transactions, _deleteTransaction),
        ),
      ],
    );
  }
}
