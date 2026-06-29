import 'package:flutter/material.dart';


class StatBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const StatBox({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Color(0xFF202020),
                )
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Font Family/Font Family',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Color(0xFF808080),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}