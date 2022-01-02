import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'models/transaction.dart';
import 'widgets/add_transaction.dart';
import 'widgets/no_transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/transaction_list_tile.dart';
import 'widgets/chart.dart';
import 'app_theme.dart';
import 'models/theme_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction(String t, double m, DateTime date) {
    final newTrans = Transaction(
      id: DateTime.now().toString(),
      title: t,
      amount: m,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTrans);
    });
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

  List<Transaction> get _lastWeekTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void _deleteTransaction(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }


  final String prefThemeIndexKey = 'themeIndex';

  void setCurrentIndexTheme() async{
    final prefs = await SharedPreferences.getInstance();
    bool curMode = Provider.of<ThemeManager>(context, listen: false).isDarkMode;
    prefs.setBool(prefThemeIndexKey, curMode);
  }

  void getCurrentIndexTheme() async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefThemeIndexKey)){
      final value = prefs.getBool(prefThemeIndexKey);
      setState(() {
        if(value != null){
          Provider.of<ThemeManager>(context, listen: false).darkMode = value;
        }
      });
    }
  }

  void _switchTheme(){
    Provider.of<ThemeManager>(context, listen: false).switchMode();
    setCurrentIndexTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentIndexTheme();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ChartWidget(_lastWeekTransactions),
          _userTransactions.isEmpty
              ? const NoTransaction()
              : TransactionList(_userTransactions, _deleteTransaction),
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
