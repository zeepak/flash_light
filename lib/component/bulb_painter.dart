import 'package:flutter/material.dart';

import '../constant/dark_color.dart';
import '../constant/light_color.dart';

class BulbPainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  BulbPainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true ? ColorOff.lightGreyColor : ColorOn.blackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Paint paint2 = Paint()
      ..color = isOff == true ? ColorOff.green : ColorOn.bulbColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    var path = Path();
    path.addArc(
        Rect.fromCenter(
            center: Offset(startPosition.dx, startPosition.dy - 85),
            width: 70,
            height: 70),
        2.35619,
        4.77);
    path.lineTo(startPosition.dx + 10, startPosition.dy - 20);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy - 12,
        startPosition.dx - 9, startPosition.dy - 20);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint2);
  }

  @override
  bool shouldRepaint(BulbPainter oldDelegate) => true;
}