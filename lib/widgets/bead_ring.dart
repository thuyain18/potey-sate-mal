import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/constants.dart';

class BeadRing extends StatelessWidget {
  final int currentCount;
  final VoidCallback onTap;

  const BeadRing({super.key, required this.currentCount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppConstants.surfaceColor,
              boxShadow: [
                BoxShadow(
                  color: AppConstants.primaryColor.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                )
              ],
            ),
          ),
          CustomPaint(
            size: const Size(260, 260),
            painter: BeadRingPainter(activeBeadIndex: currentCount % 108),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${currentCount % 108}",
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryColor),
              ),
              Text(
                "စုစုပေါင်း: ${currentCount ~/ 108} ပတ်",
                style: TextStyle(fontSize: 16, color: Colors.grey[400]),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BeadRingPainter extends CustomPainter {
  final int activeBeadIndex;
  BeadRingPainter({required this.activeBeadIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;
    const int totalBeads = 108; // ပုတီးလုံး ၁၀၈ လုံး

    for (int i = 0; i < totalBeads; i++) {
      double angle = (i * 2 * pi) / totalBeads - (pi / 2); // Start from top
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);

      bool isActive = i == activeBeadIndex;

      final Paint beadPaint = Paint()
        ..color = isActive
            ? AppConstants.accentColor
            : AppConstants.primaryColor.withValues(alpha: 0.4)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), isActive ? 5.0 : 3.0, beadPaint);
    }
  }

  @override
  bool shouldRepaint(covariant BeadRingPainter oldDelegate) {
    return oldDelegate.activeBeadIndex != activeBeadIndex;
  }
}
