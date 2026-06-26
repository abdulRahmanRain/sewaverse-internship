import 'package:flutter/material.dart';
import 'package:todo_app/helper/eleveted_button.dart';

class JobCard extends StatelessWidget {
  final String profileImage;
  final String name;
  final String tag;
  final String description;
  final String imageUrl;
  final VoidCallback onDetailsTap;
  final VoidCallback? onFavoriteTap;

  const JobCard({
    super.key,
    required this.profileImage,
    required this.name,
    required this.tag,
    required this.description,
    required this.imageUrl,
    required this.onDetailsTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage:
                profileImage.isNotEmpty
                    ? NetworkImage(profileImage)
                    : null,
                child:
                profileImage.isEmpty
                    ? const Icon(Icons.person, size: 18)
                    : null,
              ),
              const SizedBox(width: 8),

              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$name ",
                        style: TextStyle(
                          color: const Color(0xFF323232),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                        ),
                      ),
                      TextSpan(
                        text: tag,
                        style: TextStyle(
                          color: const Color(0xFF4A3AFF),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: const Color(0xFF808080),
              height: 1.6,
            )
          ),

          const SizedBox(height: 10),

          /// Job Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (
                  context,
                  child,
                  loadingProgress,
                  ) {
                if (loadingProgress == null) return child;

                return const SizedBox(
                  height: 220,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Image not available",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          /// Footer
          Row(
            children: [
              InkWell(
                onTap: onFavoriteTap,
                child: Icon(
                  Icons.favorite,
                  color: Colors.grey.shade300,
                ),
              ),

              const SizedBox(width: 15),

              Icon(
                Icons.chat_bubble_outline_outlined,
                color: Colors.grey.shade300,
              ),

              const Spacer(),

              SizedBox(
                height: 38,
                child: customElevatedButton(text: "Get Details", onPressed: onDetailsTap, elevation: 0,padding: EdgeInsetsGeometry.symmetric(horizontal: 16,vertical: 6),fontSize: 14,borderRadius: 20,backgroundColor: Color(0xFF1863F8) )
              ),
            ],
          ),
        ],
      ),
    );
  }
}