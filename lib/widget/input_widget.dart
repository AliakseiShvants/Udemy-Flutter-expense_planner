import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputWidget extends StatefulWidget {
  final Function _addTransactionCallback;

  InputWidget(this._addTransactionCallback);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _titleController = new TextEditingController();
  final _amountController = new TextEditingController();
  final first = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 7);
  final last = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 7);
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
          top: 16,
          right: 8,
          left: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => _submit,
          ),
          TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submit),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(_datePicker == null
                      ? 'No date'
                      : 'Picked date: ${DateFormat.yMd().format(_datePicker)}'),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    'Choose date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _getDatePicker,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            child: RaisedButton(
              onPressed: _submit,
              child: Text('Add'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
          )
        ],
      ),
    );
  }
}
