import 'package:flutter/material.dart';

Widget customElevatedButton({
  required String text,
  required VoidCallback onPressed,
  Color backgroundColor = Colors.blue,
  Color foregroundColor = Colors.white,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.bold,
  double borderRadius = 16,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  double elevation = 5,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: elevation,
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}