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
      ..strokeWidth = 2;
  }

  double calculateSinRule(double aDegrees, double cDegrees, double cLength) {
    return cLength *
        math.sin(aDegrees * math.pi / 180) /
        math.sin(cDegrees * math.pi / 180);
  }

  List<double> rotateCoordinate(double x, double y, double degrees) {
    num rads = vector_math.radians(degrees);
    return [
      x * math.cos(rads) - y * math.sin(rads),
      x * math.sin(rads) + y * math.cos(rads)
    ];
  }

  void testDraw1(Canvas canvas, Size size) {
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
//    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);

    path.moveTo(0, 0);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: Radius.circular(1.0),
    );
    canvas.drawPath(path, _paint);
  }

  void testDraw2(Canvas canvas, Size size, double rotation) {
    // example degree = 50, 60, 70
    // example 70 deg = 100%
    // sine rule => a/sin50 == b/sin60 == 100/sin70
    // https://doubleroot.in/lessons/coordinate-geometry-basics/rotation-of-axes/#:~:text=Consider%20a%20point%20P(x,%CE%B8%20in%20the%20anticlockwise%20direction.&text=To%20find%20the%20new%20coordinates,point%20from%20the%20rotated%20axes.
    // x = Xcosθ – Ysinθ
    // y = Xsinθ + Ycosθ.

    // math (special triangle) 3 4 5
    // double aDegrees = 36.87;
    // double bDegrees = 53.13;
    // double cDegrees = 90;

    double aDegrees = 36.87;
    double bDegrees = 53.13;
    double cDegrees = 90;

    double cLength = 5;
    double aLength = calculateSinRule(aDegrees, cDegrees, cLength);
    double bLength = calculateSinRule(bDegrees, cDegrees, cLength);

    print(cLength);
    print(aLength);
    print(bLength);

    double rotateDegree = rotation;
    List<double> rotatedLine = rotateCoordinate(size.width, 0, rotateDegree);

    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(rotatedLine[0], rotatedLine[1]);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1, -1);
    testDraw2(canvas, size, 45);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
