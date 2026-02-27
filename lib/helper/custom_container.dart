import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/constants/users_and_time.dart';
import 'package:todo_app/helper/eleveted_button.dart';


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
    required bool isActiveColor
  }) {
    return Container(
      
      width: double.infinity,
      padding: EdgeInsets.only(top:  2).add(EdgeInsets.symmetric(horizontal: AppSpacing.mediumPadding-5)),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(AppSpacing.mediumRadius+10),
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
          ListTile(
            contentPadding: EdgeInsets.only(left: 0,),
            leading: Card(
              elevation: 1,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://www.bollywoodhungama.com/wp-content/uploads/2022/09/574f7b65-6f79-4245-bb17-6df622da1d3d.jpg'
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            subtitle: Text(UsersAndTime.time),
          ),
          Text(
            body,
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
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
          SizedBox(height: AppSpacing.small),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage('https://thumbs.dreamstime.com/b/idyllic-summer-landscape-clear-mountain-lake-alps-45054687.jpg',),
                fit: BoxFit.cover
              )
            ),

          ),
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: onTapOnLike,
                      icon: Icon(Icons.favorite_border,color: isActiveColor ? Colors.red:Colors.black,)
                  ),
                  Text(likeCount.toString(),style: TextStyle(color: Colors.black)),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: onTapOnComment, icon: Icon(Icons.chat_bubble_outline,color: Colors.black,)),
                  Text("0",style: TextStyle(color: Colors.black))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){}, icon: Image.asset("assets/share.png",width: 20, color: Colors.black,
                    height: 22)),
                  SizedBox(width:0,),
                  Text("0",style: TextStyle(color: Colors.black),)
                ],
              ),
              Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: 65,
                    height: 30,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,

                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              image: DecorationImage(image: NetworkImage('https://mayankshekhar.com/wp-content/uploads/2022/01/Shah-Rukh-Khan.jpg'),fit: BoxFit.cover)  ),
                          )
                        ),
                        Positioned(
                          left: 18,
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                image: DecorationImage(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqNzEDRRW6Py0Jz1O3XgCrzhRBv6KaP-3bTA&s'),fit: BoxFit.cover),
                              )
                          )
                        ),
                        Positioned(
                          left: 35,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              image: DecorationImage(image: NetworkImage('https://mayankshekhar.com/wp-content/uploads/2022/01/Shah-Rukh-Khan.jpg'),fit: BoxFit.cover),
                            )
                          )
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 8),

                  Text(
                    "6 friends liked",
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey[700],
                      letterSpacing: -0.5
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 4,),
          if (isExpandedComment) ...[
            Row(
              children: [
                Expanded(child: textField),
                SizedBox(width: AppSpacing.small-5,),
                customElevatedButton(text: "Post", onPressed: (){})
              ],
            ), 
            SizedBox(height: AppSpacing.medium - 5),
          ],
        ],
      )
    );
  }
}