import 'package:flutter/material.dart';

class AppLabel extends StatelessWidget {
  final String text;

  const AppLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.0,
        letterSpacing: 0,
        color: Color(0xFF474747),
      ),
    );
  }
}