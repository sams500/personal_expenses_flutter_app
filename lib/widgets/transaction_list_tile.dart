import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionListTile extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  const TransactionListTile(this.transactions, this._deleteTransaction,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '\$${transactions[index].amount}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                radius: 30,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                DateFormat('yyyy-MM-dd').format(transactions[index].date),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () => _deleteTransaction(index),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
