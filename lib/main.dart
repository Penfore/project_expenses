import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_expenses/components/chart.dart';
import 'package:project_expenses/components/transaction_form.dart';
import 'package:project_expenses/models/transaction.dart';

import 'components/transaction_list.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  ExpensesApp({Key? key}) : super(key: key);

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage(),
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: Colors.purple,
              secondary: Colors.amber,
            ),
            textTheme: theme.textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              button: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ))));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      centerTitle: true,
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor),
      ),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () => setState(() {
              _showChart = !_showChart;
            }),
            icon: Icon(
              (_showChart ? Icons.list_alt : Icons.show_chart),
            ),
          ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );

    final avaiableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /* if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Exibir gráfico'),
                  Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ), */
            if (_showChart || !isLandscape)
              SizedBox(
                height: avaiableHeight * (isLandscape ? 0.70 : 0.30),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: avaiableHeight * 0.70,
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
