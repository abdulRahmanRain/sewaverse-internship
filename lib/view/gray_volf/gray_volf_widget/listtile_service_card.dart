import 'package:flutter/material.dart';
import 'package:todo_app/helper/eleveted_button.dart';

class ListTileServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onBook;

  const ListTileServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:  BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              width: 220,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // space text & button
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 40,
                      width: 101,
                      child: customElevatedButton(
                        text: "Book Now",
                        onPressed: onBook,
                        borderRadius: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        backgroundColor: const Color(0xFF1863F8),
                        elevation: 0,
                        textStyle: const TextStyle(
                          fontFamily: 'Font Family/Font Family',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.0,
                          letterSpacing: 0.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
