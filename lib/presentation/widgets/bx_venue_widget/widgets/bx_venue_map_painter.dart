// File: lib/presentation/widgets/bx_venue_widget/widgets/bx_venue_map_painter.dart
// Architecture: Presentation Layer - Venue Widgets
// Purpose: Custom painter for the abstract map background lines

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class BxVenueMapPainter extends CustomPainter {
  const BxVenueMapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    // --- Line 1 (wavy horizontal) ---
    final path1 = Path();
    path1.moveTo(0, size.height * 0.4);
    path1.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.2,
      size.width * 0.6,
      size.height * 0.8,
    );
    path1.quadraticBezierTo(
      size.width * 0.8,
      size.height * 1.1,
      size.width,
      size.height * 0.7,
    );
    canvas.drawPath(path1, paint);

    // --- Line 2 (curving right) ---
    final path2 = Path();
    path2.moveTo(size.width * 0.2, 0);
    path2.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.4,
      size.width * 0.8,
      size.height * 0.5,
    );
    canvas.drawPath(path2, paint);

    // --- Line 3 (bottom right curve) ---
    final path3 = Path();
    path3.moveTo(size.width * 0.8, 0);
    path3.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.6,
      size.width * 1.1,
      size.height * 0.8,
    );
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
