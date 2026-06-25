import 'package:flutter/material.dart';

class CustomIconContainer extends StatelessWidget {
  final Widget icon;

  const CustomIconContainer({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return Container(
      height: 50,
      width: 60,
      decoration: BoxDecoration(
        color: themeColor.secondary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}