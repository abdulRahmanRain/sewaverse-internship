import 'package:flutter/material.dart';

class CustomGrayvolfBack extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final String logoPath;

  const CustomGrayvolfBack({
    super.key,
    this.onBackPressed,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBackPressed ?? () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: const Color(0xFFDCDCDC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF1863F8),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Image.asset(
          logoPath,
          height: 24,
          width: 91.2,
          color: Theme.of(context).colorScheme.secondary
        ),
      ],
    );
  }
}