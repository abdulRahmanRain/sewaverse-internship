import 'package:flutter/material.dart';
import 'package:todo_app/helper/eleveted_button.dart';

class ProfileCard extends StatelessWidget {
  final String backgroundImageUrl;
  final String profileImageUrl;
  final String name;
  final String followOrEditText;
  final String handle;
  final String posts;
  final String followers;
  final String following;
  final VoidCallback onFollow;

  const ProfileCard({
    super.key,
    required this.backgroundImageUrl,
    required this.profileImageUrl,
    required this.name,
    required this.followOrEditText,
    required this.handle,
    required this.posts,
    required this.followers,
    required this.following,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 300,
          width: width*1,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Image.network(
            backgroundImageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(profileImageUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ],
                          ),
                          Text(
                            handle,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    customElevatedButton(
                        text: followOrEditText,
                        onPressed: onFollow,
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(color: Colors.blue),
                      borderRadius: 30,
                      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 0)
                    ),
                    SizedBox(width: 10,),
                    CircleAvatar(
                      child: Icon(Icons.email_rounded, color: Colors.blue,),
                      backgroundColor: Colors.white,
                      radius: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
