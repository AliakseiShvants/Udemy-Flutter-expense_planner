import 'package:expense_planner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputWidget extends StatefulWidget {
  final Function _addTransactionCallback;

  const InputWidget(this._addTransactionCallback);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _titleController = new TextEditingController();
  final _amountController = new TextEditingController();
  final first = new DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day - Constants.DAYS_OF_WEEK);
  final last = new DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day + Constants.DAYS_OF_WEEK);
  DateTime _datePicker = DateTime.now();

  void _submit() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final inputTitle = _titleController.text;
    final inputAmount = double.parse(_amountController.text);

    if (inputTitle.isEmpty || inputAmount.isNegative) {
      return;
    }

    widget._addTransactionCallback(inputTitle, inputAmount, _datePicker);

    Navigator.of(context).pop();
  }

  void _getDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: first,
      lastDate: last,
    ).then((date) {
      if (date == null) {
        return;
      }

      setState(() {
        _datePicker = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Constants.PADDING_M,
        right: Constants.PADDING_S,
        left: Constants.PADDING_S,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: Constants.TITLE),
            controller: _titleController,
            onSubmitted: (_) => _submit,
          ),
          TextField(
            decoration: const InputDecoration(labelText: Constants.AMOUNT),
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submit,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(_datePicker == null
                      ? Constants.NO_DATA
                      : '${Constants.PICKED_DATE} ${DateFormat.yMd().format(_datePicker)}'),
                ),
                FlatButton(
                  padding: EdgeInsets.all(Constants.DEFAULT_DOUBLE),
                  child: const Text(
                    Constants.CHOOSE_DATE,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _getDatePicker,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.DEFAULT_DOUBLE,
              vertical: Constants.PADDING_M,
            ),
            child: RaisedButton(
              onPressed: _submit,
              child: const Text(Constants.ADD),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
          )
        ],
      ),
    );
  }
}
