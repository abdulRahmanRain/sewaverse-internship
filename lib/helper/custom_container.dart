import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/helper/text_fileld_helper.dart';

class CustomContainer {
  static Widget build({
    required String title,
    required String body,
    required bool isExpanded,
    required bool isExpandedComment,
    required VoidCallback onTap,
    required VoidCallback onTapOnLike,
    required VoidCallback onTapOnComment,
    required int likeCount,
    required Widget textField,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top:  AppSpacing.mediumPadding).add(EdgeInsets.symmetric(horizontal: AppSpacing.mediumPadding)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.mediumRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            body,
            maxLines: isExpanded ? null : 2,
            overflow:
            isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              isExpanded ? "Show Less" : "Show More",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.medium),
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: onTapOnLike,
                      icon: Icon(Icons.heart_broken)
                  ),
                  Text(likeCount.toString()),
                ],
              ),
              SizedBox(width: AppSpacing.small,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: onTapOnComment, icon: Icon(Icons.comment)),
                  Text("0")
                ],
              ),
              SizedBox(width: AppSpacing.small,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.screen_share_rounded)),
                  Text("0")
                ],
              ),
            ],
          ),
          if (isExpandedComment)
            textField,
            SizedBox(height:10)
        ],
      )
    );
  }
}