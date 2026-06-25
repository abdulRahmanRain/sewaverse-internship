import 'package:flutter/material.dart';

class AppLabel extends StatelessWidget {
  final String text;

  const AppLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      text,
      style: textTheme.labelMedium
    );
  }
}