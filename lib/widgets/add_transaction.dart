import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function _addTransaction;

  const AddTransaction(this._addTransaction, {Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (titleController.text == '' ||
        amountController.text == '' ||
        double.parse(amountController.text) <= 0 || _selectedDate == null) {
      return;
    }
    widget._addTransaction(
      titleController.text,
      double.parse(amountController.text),
      _selectedDate
    );

    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((date) {
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              style: Theme.of(context).textTheme.bodyText1,
              // autofocus: true,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyText1,
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen yet!'
                          : 'Picked Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                'Add Transaction',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
