import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class ChartWidget extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const ChartWidget(this.recentTransactions, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get _totalWeeklyAmount {
    // var totalAmount = 0.0;
    // for (var element in groupedTransactionValues) {
    //   totalAmount += (element['amount'] as double);
    // }
    // return totalAmount == 0.0 ? 1 : totalAmount;
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
  }
}
