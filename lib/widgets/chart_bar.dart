import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double amountPercentage;

  const ChartBar(
      {required this.label,
      required this.amount,
      required this.amountPercentage,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: FittedBox(
              child: Text('\$${amount.toStringAsFixed(0)}'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: amountPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(label),
        ],
      ),
    );
  }
}
