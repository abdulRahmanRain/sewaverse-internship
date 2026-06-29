import 'package:flutter/material.dart';

class ProfileDataContainer extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Widget? trailing;
  const ProfileDataContainer({
    super.key,
    required this.title,
    this.icon,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [

          if (icon != null)
            Icon(icon, color: iconColor ?? Colors.black),

          if (icon != null) const SizedBox(width: 12),

          // Text
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.0,
                letterSpacing: 0.0,
                color: Color(0xFF808080),
              ),
            ),
          ),

          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
