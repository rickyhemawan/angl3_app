import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector_math;

class DrawTriangle extends StatefulWidget {
  @override
  _DrawTriangleState createState() => _DrawTriangleState();
}

class _DrawTriangleState extends State<DrawTriangle> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height / 3,
      color: Colors.tealAccent,
      alignment: Alignment.center,
      child: CustomPaint(
        size: Size.square(screenSize.height / 3.5),
        painter: DrawTrianglePainter(),
      ),
    );
  }
}

class DrawTrianglePainter extends CustomPainter {
  Paint _paint;

  DrawTrianglePainter() {
    _paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, _paint);
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final startAngle = vector_math.radians(0);
    final sweepAngle = vector_math.radians(360);
    final useCenter = false;
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
