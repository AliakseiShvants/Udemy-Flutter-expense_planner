import 'package:flutter/material.dart';

import 'entity/transaction.dart';
import 'widget/portrait_main_widget.dart';
import 'widget/input_widget.dart';
import 'widget/transaction_list_widget.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactions = [
    Transaction('New Book', 60, date: DateTime.now()),
    Transaction('Food', 19.99, date: DateTime.now()),
    Transaction('Food', 19.99, date: DateTime.now()),
    Transaction('Food', 19.99, date: DateTime.now()),
    Transaction('Food', 19.99, date: DateTime.now()),
    Transaction('Food', 19.99, date: DateTime.now()),
    Transaction('Food', 19.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = new Transaction(title, amount, date: date);

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _addNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) => InputWidget(_addTransaction),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.0))));
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _addNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: isPortrait
            ? PortraitMainWidget(
                appBar, _transactions, _recentTransactions, _deleteTransaction)
            : Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    1,
                child: TransactionListWidget(_transactions, _deleteTransaction),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _addNewTransaction(context),
      ),
    );
  }
}
