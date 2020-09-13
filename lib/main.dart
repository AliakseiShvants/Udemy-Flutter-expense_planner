import 'utils/constants.dart';
import 'utils/themes.dart';
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
      title: Constants.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        fontFamily: Constants.QUICK_SAND,
        textTheme: Themes.mainTextTheme,
        appBarTheme: AppBarTheme(
          textTheme: Themes.appBarTextTheme,
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
      return element.date.isAfter(
          DateTime.now().subtract(Duration(days: Constants.DAYS_OF_WEEK)));
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
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Constants.BORDER_RADIUS),
        ),
      ),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    final appBar = AppBar(
      title: const Text(Constants.APP_NAME),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
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
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    1,
                child: TransactionListWidget(_transactions, _deleteTransaction),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _addNewTransaction(context),
      ),
    );
  }
}
