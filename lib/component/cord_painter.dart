import 'package:flash_light/constant/dark_color.dart';
import 'package:flash_light/constant/light_color.dart';
import 'package:flutter/material.dart';

class CordPainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  CordPainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true ? ColorOff.lightGreyColor : ColorOn.blackColor
      ..strokeWidth = 4;
      
    canvas.drawLine(startPosition, endPosition, paint);
    canvas.drawCircle(Offset(endPosition.dx, endPosition.dy), 4, paint);
  }

  @override
  bool shouldRepaint(CordPainter oldDelegate) => true;
}