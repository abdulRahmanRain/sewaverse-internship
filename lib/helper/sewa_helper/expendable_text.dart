import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';


class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 1,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppSizes.fontLarge,
            color: Colors.grey[800],
          ),
        ),

        const SizedBox(height: AppSizes.paddingXS),

        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? "Show less" : "Show more",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue,
              fontSize: AppSizes.fontSmall
            ),
          ),
        )
      ],
    );
  }
}