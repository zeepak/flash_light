import 'package:flutter/material.dart';

import '../constant/dark_color.dart';
import '../constant/light_color.dart';

class BulbOvalPainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  BulbOvalPainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true ? ColorOff.lightGreyColor : ColorOn.blackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    Paint paint2 = Paint()
      ..color = isOff == true ? ColorOff.ovalColor : ColorOn.ovalColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Path path = Path();
    path.moveTo(startPosition.dx + 16, startPosition.dy - 40);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy - 55,
        startPosition.dx - 15, startPosition.dy - 40);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy - 30,
        startPosition.dx + 16, startPosition.dy - 40);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint2);
  }

  @override
  bool shouldRepaint(BulbOvalPainter oldDelegate) => true;
}