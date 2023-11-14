import 'package:flutter/material.dart';

import '../constant/dark_color.dart';

class LinePainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  LinePainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true
          ? ColorOff.mediumGreyColor
          : const Color.fromARGB(255, 198, 240, 30)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;


    Path path = Path();
    path.moveTo(startPosition.dx - 5, startPosition.dy - 40);
    path.lineTo(startPosition.dx - 10, startPosition.dy - 55);

    canvas.drawPath(path, paint);

    path.moveTo(startPosition.dx + 5, startPosition.dy - 40);
    path.lineTo(startPosition.dx + 10, startPosition.dy - 55);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}