import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function(String p1) onRemove;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: Text(
                'R\$${transaction.value.toString()}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd/MM/y').format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                onPressed: () => onRemove(transaction.id),
                icon: const Icon(Icons.delete),
                label: Text(
                  'Excluir',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => onRemove(transaction.id),
              ),
      ),
    );
  }
}
