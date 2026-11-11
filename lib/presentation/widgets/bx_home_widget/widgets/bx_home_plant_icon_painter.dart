// File: lib/presentation/widgets/bx_home_widget/widgets/bx_home_plant_icon_painter.dart
// Architecture: Presentation Layer - Bx Home Widgets
// Purpose: Custom painter for the decorative "plant" icon inside the featured card

import 'package:flutter/material.dart';

class BxHomePlantIconPainter extends CustomPainter {
  const BxHomePlantIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final w = size.width;
    final h = size.height;
    final path = Path();

    // 1. Left Petal
    path.moveTo(w * 0.5, h * 0.95);
    path.quadraticBezierTo(w * 0.05, h * 0.8, w * 0.15, h * 0.25);
    path.quadraticBezierTo(w * 0.35, h * 0.45, w * 0.5, h * 0.9);
    path.close();

    // 2. Right Petal
    path.moveTo(w * 0.5, h * 0.95);
    path.quadraticBezierTo(w * 0.95, h * 0.8, w * 0.85, h * 0.25);
    path.quadraticBezierTo(w * 0.65, h * 0.45, w * 0.5, h * 0.9);
    path.close();

    // 3. Center Petal
    path.moveTo(w * 0.5, h * 0.95);
    path.quadraticBezierTo(w * 0.15, h * 0.6, w * 0.5, h * 0.05);
    path.quadraticBezierTo(w * 0.85, h * 0.6, w * 0.5, h * 0.95);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
