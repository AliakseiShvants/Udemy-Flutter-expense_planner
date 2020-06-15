import 'package:expense_planner/utils/constants.dart';
import 'package:expense_planner/widget/chart_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:expense_planner/entity/transaction.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const ChartWidget(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(Constants.DAYS_OF_WEEK, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = Constants.DEFAULT_DOUBLE;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        Constants.DAY : DateFormat.E().format(weekDay).substring(0, 1),
        Constants.AMOUNT : totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(Constants.DEFAULT_DOUBLE, (sum, item) {
      return sum + item[Constants.AMOUNT];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Constants.CARD_ELEVATION,
      child: Container(
        padding: EdgeInsets.all(Constants.CARD_PADDING),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBarWidget(
                data[Constants.DAY],
                data[Constants.AMOUNT],
                totalSpending == Constants.DEFAULT_DOUBLE
                    ? Constants.DEFAULT_DOUBLE
                    : (data[Constants.AMOUNT] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
