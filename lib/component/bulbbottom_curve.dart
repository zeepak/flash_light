import 'package:flutter/material.dart';

import '../constant/dark_color.dart';
import '../constant/light_color.dart';

class BulbBottomCurvePainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  BulbBottomCurvePainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true ? ColorOff.lightGreyColor : ColorOn.blackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Paint paint2 = Paint()
      ..color =
          isOff == true ? ColorOff.mediumGreyColor : ColorOff.lightGreyColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Path path = Path();
    path.moveTo(startPosition.dx - 15, startPosition.dy - 10);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy + 10,
        startPosition.dx + 15, startPosition.dy - 10);
    path.lineTo(startPosition.dx + 17, startPosition.dy - 40);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy - 55,
        startPosition.dx - 17, startPosition.dy - 40);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint2);
  }

  @override
  bool shouldRepaint(BulbBottomCurvePainter oldDelegate) => true;
}