import 'dart:math';

class Transaction {
  final String id = Random().nextInt(100).toString();
  final String title;
  final double amount;
  final DateTime date;

  Transaction(this.title, this.amount, {this.date});
}
