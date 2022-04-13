import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class AdaptativeTextField extends StatelessWidget {
  final String? label;
  final Function(dynamic) onSubmitted;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const AdaptativeTextField({
    required this.label,
    required this.onSubmitted,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            placeholder: label,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            controller: controller,
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 12,
            ),
          )
        : TextField(
            decoration: InputDecoration(
              labelText: label,
            ),
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            controller: controller,
          );
  }
}
