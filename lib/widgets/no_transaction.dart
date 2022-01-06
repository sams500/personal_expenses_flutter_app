import 'package:flutter/material.dart';

class NoTransaction extends StatelessWidget {
  const NoTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'No Transaction yet! ',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/images/no_transaction.png',
            fit: BoxFit.fill,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
