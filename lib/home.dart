import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:personal_expenses_app/database/moor/moor_db.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/basic.dart' as W;

import 'widgets/add_transaction.dart';

import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';
import 'theme_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String prefThemeIndexKey = 'themeIndex';

  @override
  void initState() {
    super.initState();
    getCurrentIndexTheme();
  }
  
  
  void _switchTheme() {
    Provider.of<ThemeManager>(context, listen: false).switchMode();
    setCurrentIndexTheme();
  }
  
  void setCurrentIndexTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool curMode = Provider.of<ThemeManager>(context, listen: false).isDarkMode;
    prefs.setBool(prefThemeIndexKey, curMode);
  }

  void getCurrentIndexTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefThemeIndexKey)) {
      final value = prefs.getBool(prefThemeIndexKey);
      setState(() {
        if (value != null) {
          Provider.of<ThemeManager>(context, listen: false).darkMode = value;
        }
      });
    }
  }
  
  
  void _startAddNewTransaction(BuildContext ctxt) {
    showModalBottomSheet<void>(
      context: ctxt,
      builder: (_) {
        return GestureDetector(
          child: AddTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Future _addNewTransaction(String t, double m, DateTime date) async {
    final newT = MoorTransactionsCompanion(
      title: Value(t),
      amount: Value(m),
      date: Value(date),
    );
    Provider.of<TransactionDao>(context, listen: false).insertTransaction(newT);
  }

  void _deleteTransaction(MoorTransaction transaction) {
    Provider.of<TransactionDao>(context, listen: false)
        .deleteTransaction(transaction);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expanses App'),
        actions: [
          IconButton(
            onPressed: _switchTheme,
            icon: const Icon(Icons.app_settings_alt_outlined),
          ),
        ],
      ),
      body: W.Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ChartWidget(),
          TransactionList(_deleteTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
        tooltip: 'Delete this transaction',
      ),
    );
  }
}
