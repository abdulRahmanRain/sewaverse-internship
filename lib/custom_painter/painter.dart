import 'package:flutter/material.dart';

class RibbonBanner extends StatelessWidget {
  final String text;
  final String subtext;

  const RibbonBanner({super.key, required this.text, required this.subtext});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65, // banner height
      width: 40,  // banner width
      child: CustomPaint(
        painter: BannerPainter(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                subtext,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return; // safety

    Paint paint = Paint()
      ..color = const Color(0xFFF44336)
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Start at top-left
    path.moveTo(0, 0);
    // Top-right
    path.lineTo(size.width, 0);
    // Bottom-right
    path.lineTo(size.width, size.height);
    // V-cut middle point
    path.lineTo(size.width / 2, size.height * 0.85);
    // Bottom-left
    path.lineTo(0, size.height);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}