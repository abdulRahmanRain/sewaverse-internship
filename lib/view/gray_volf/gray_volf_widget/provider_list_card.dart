import 'package:flutter/material.dart';


class ProviderListCard extends StatefulWidget {
  final String name;
  final String location;
  final String avatarUrl;
  final VoidCallback? onFollowPressed;
  final bool isFollowing;

  const ProviderListCard({
    super.key,
    required this.name,
    required this.location,
    required this.avatarUrl,
    this.onFollowPressed,
    this.isFollowing = false,
  });

  @override
  State<ProviderListCard> createState() => _ProviderListCardState();
}

class _ProviderListCardState extends State<ProviderListCard> {
  late bool _isFollowing;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.isFollowing;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            backgroundImage: NetworkImage(widget.avatarUrl),
            child: ClipOval(
              child: Image.network(
                widget.avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name and Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Color(0xFF999999),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isFollowing = !_isFollowing;
                });
                widget.onFollowPressed?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFollowing
                    ? const Color(0xFFF0F0F0)
                    : const Color(0xFF1863F8),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: _isFollowing
                        ? const Color(0xFFE0E0E0)
                        : Colors.transparent,
                  ),
                ),
                elevation: 0,
              ),
              child: Text(
                _isFollowing ? 'Following' : 'Follow',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _isFollowing
                      ? const Color(0xFF666666)
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}