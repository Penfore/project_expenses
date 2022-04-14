import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class AdaptativeButton extends StatelessWidget {
  final String? label;
  final void Function()? onPressed;

  const AdaptativeButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label!),
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(label!),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color?>(
                    Theme.of(context).colorScheme.primary),
                foregroundColor: MaterialStateProperty.all<Color?>(
                    Theme.of(context).textTheme.button!.color)),
          );
  }
}