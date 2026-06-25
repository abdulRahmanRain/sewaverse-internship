import 'package:flutter/material.dart';

Widget customElevatedButton({
  required String text,
  required VoidCallback onPressed,
  Color backgroundColor = Colors.blue,
  Color foregroundColor = Colors.white,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.bold,
  double borderRadius = 16,
  EdgeInsetsGeometry padding =
  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  double elevation = 5,
  TextStyle? textStyle,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    child: Text(
      text,
      style: textStyle ??
          TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
    ),
  );
}