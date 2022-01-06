import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/database/moor/moor_db.dart';
import 'package:provider/provider.dart';
import '../database/sqflite/transaction.dart';
import 'chart_bar.dart';

class ChartWidget extends StatefulWidget {

  const ChartWidget({Key? key}) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  late List<MoorTransaction> lastWeekTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var i = 0; i < lastWeekTransactions.length; i++) {
        if (lastWeekTransactions[i].date.day == weekDay.day &&
            lastWeekTransactions[i].date.month == weekDay.month &&
            lastWeekTransactions[i].date.year == weekDay.year) {
          totalSum += lastWeekTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get _totalWeeklyAmount {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MoorTransaction>>(
        stream: Provider.of<TransactionDao>(context, listen: false)
            .watchLastWeekTransactions(DateTime.now()),
        builder: (context, snapshot) {
          lastWeekTransactions = snapshot.data ?? [];
          return Card(
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(
                      'Total Expenses: \$${_totalWeeklyAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: groupedTransactionValues.map((e) {
                    return Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                        label: e['day'] as String,
                        amount: e['amount'] as double,
                        amountPercentage: _totalWeeklyAmount == 0.0
                            ? 0.0
                            : (e['amount'] as double) / _totalWeeklyAmount,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        });
  }
}
