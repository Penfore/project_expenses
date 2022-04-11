import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (itemBuilderContext, index) {
            final transaction = transactions[index];
            return Card(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2)),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "R\$ ${transaction.value.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        DateFormat('d/MM/y').format(transaction.date),
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
