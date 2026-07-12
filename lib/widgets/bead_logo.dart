import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/constants.dart';

class BeadLogo extends StatelessWidget {
  final double size;
  const BeadLogo({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: BeadLogoPainter(),
    );
  }
}

class BeadLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;
    final beadRadius = size.width * 0.05;

    final Paint stringPaint = Paint()
      ..color = AppConstants.primaryDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Paint beadPaint = Paint()
      ..color = AppConstants.primaryColor
      ..style = PaintingStyle.fill;

    // Draw background circle string
    canvas.drawCircle(center, radius, stringPaint);

    // Draw 9 main decorative beads on the logo
    for (int i = 0; i < 9; i++) {
      double angle = (i * 2 * pi) / 9;
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);
      canvas.drawCircle(Offset(x, y), beadRadius, beadPaint);

      // Bead Highlight effect
      canvas.drawCircle(Offset(x - beadRadius * 0.3, y - beadRadius * 0.3),
          beadRadius * 0.2, Paint()..color = Colors.white70);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
