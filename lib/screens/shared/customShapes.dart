import 'package:flutter/material.dart';
import 'package:tc_college_app/screens/shared/constants.dart';

class WelcomeCustomShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = themeColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    final double radiusX = size.shortestSide * 0.4;
    final double radiusY = size.shortestSide * 0.22;

    final Rect rect = Rect.fromCenter(
        center: Offset(size.width * 0.3, size.height * 0.065),
        width: radiusX * 2,
        height: radiusY * 2);

    canvas.drawOval(rect, paint);

    final fillPaint = Paint();
    fillPaint.color = themeColor;
    fillPaint.style = PaintingStyle.fill;
    canvas.drawOval(rect, fillPaint);

    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    );

    final textSpan = TextSpan(
      text: 'Welcome',
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Calculate the center of the oval
    final ovalCenter = Offset(rect.center.dx, rect.center.dy);

    // Calculate the position to center the text within the oval
    final textX = (ovalCenter.dx - textPainter.width / 2) + (size.width * 0.05);
    final textY = (ovalCenter.dy - textPainter.height / 2) + (size.width * 0.07);

    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 77, 16, 16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.moveTo(size.width * 0.5, 0); //Ax, Ay
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.125, size.width * 0.4, size.height * 0.25); //Bx, By, Cx, Cy
    path.quadraticBezierTo(0.1, 3 * size.height * 0.13, size.width * 1.0, size.height * 0.5);
    path.lineTo(0, size.height * 0.5);
    path.lineTo(0.0, 0.0); 
    path.lineTo(size.width * 0.5, 0);
    canvas.drawPath(path, paint);
    Paint fillColor = Paint();
    fillColor.color = Color.fromARGB(255, 77, 16, 16);
    fillColor.style = PaintingStyle.fill;
    canvas.drawPath(path, fillColor);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}
