import 'package:flutter/material.dart';

import '../constant/dark_color.dart';

class AnimatedCordPainter extends CustomPainter {
  Offset startPosition;
  double curve;
  double height;
  double height2;
  bool isOff;
  AnimatedCordPainter(
      this.startPosition, this.curve, this.height, this.height2, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    final Paint paint = Paint();
    paint.color = isOff == true ? ColorOff.lightGreyColor : Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;
    paint.strokeCap = StrokeCap.round;

    path.moveTo(startPosition.dx, startPosition.dy);
    path.quadraticBezierTo(startPosition.dx + curve, startPosition.dy + 20,
        startPosition.dx, startPosition.dy + 40);
    path.quadraticBezierTo(startPosition.dx + height, startPosition.dy + 60,
        startPosition.dx, startPosition.dy + 100 + height2);
    canvas.drawCircle(
        Offset(startPosition.dx, startPosition.dy + 100 + height2), 2, paint);

    canvas.drawPath(path, paint);
    // Add path points here based on your needs
  }

  @override
  bool shouldRepaint(AnimatedCordPainter oldDelegate) {
    return true;
  }
}