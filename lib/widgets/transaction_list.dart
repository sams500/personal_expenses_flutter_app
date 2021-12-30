import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(this.transactions, this.deleteTransaction, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            elevation: 6,
            child: Row(
              children: [
                Container(
                  child: FittedBox(
                    child: Text(
                      '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd')
                            .format(transactions[index].date),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => deleteTransaction(index),
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 30,
                  ),
                )
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
