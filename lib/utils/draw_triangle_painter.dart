import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector_math;
import 'package:flutter/painting.dart';

class DrawTrianglePainter extends CustomPainter {
  // [calculateSinRule] will calculate the
  // The length of a angle according to the "Sin Rule"
  // Which is a/sinA = c/sinC
  // Where the capital letters are the angle
  // And the lower case letters are the sides
  double calculateSinRule(double aDegrees, double cDegrees, double cLength) {
    return cLength *
        math.sin(aDegrees * math.pi / 180) /
        math.sin(cDegrees * math.pi / 180);
  }

  // [rotateCoordinate] will move the
  // coordinate according to the base position
  // therefore it will still retains it length,
  // without increasing it
  List<double> rotateCoordinate(double x, double y, double degrees) {
    num rads = vector_math.radians(degrees);
    return [
      x * math.cos(rads) - y * math.sin(rads),
      x * math.sin(rads) + y * math.cos(rads)
    ];
  }

  void drawTriangleFromDegrees({
    @required Canvas canvas,
    @required Size size,
    @required List<double> angles,
  }) {
    Rect rect = Rect.fromLTWH(0, 0, size.height, size.height);

    final Gradient gradient = LinearGradient(
      colors: <Color>[
        Color(0xffC60000),
        Color(0xffCF1129),
        Color(0xffD42863),
        Color(0xff7117EA),
        Color(0xff7117EA),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    Paint _paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    // Where all of the sides length percentage will go
    // middle percentage of triangle will always be 1
    // which indicate that the value of the second sides is 100% of size.width
    // So it have starting point of 'a/SinA' which is essential for the 'Sin Rule'
    final List<double> sides = [0, 1.0, 0];

    // The basic rule of creating a triangle requires 3 and only 3 angle.
    // It is required for 3 of those has the equal of 180 and only 180.
    // Therefore exception will be thrown if doesn't met the required
    // specification.
    if (angles.length != 3) throw ("angles.length must equal to 3 ");
    if (angles.reduce((value, element) => value + element) != 180)
      throw ("The sum of angles must equal to 180");
    // Sort angles by ascending order (small to big)
    angles.sort();

    if (angles[2] > 90) sides[1] = 0.75;
    if (angles[2] > 115) sides[1] = 0.5;
    if (angles[2] > 145) sides[1] = 0.25;

    // Assigning all of the other sides according to their length
    for (int i = 0; i < 3; i += 2)
      sides[i] = calculateSinRule(angles[i], angles[1], sides[1]);

    // Modifying canvas so it always start at the
    // bottom left of canvas instead of top right
    canvas
      ..translate(0, size.height)
      ..scale(1, -1);

    // for the width its use the smallest angle,
    // for the angle its use the biggest,
    // because that how 'Sin Rule' works
    // since middle length will always be drawn first
    // at the bottom of the triangle based on the illustration
    // below
    //       .
    //       .b .
    //       .    .
    //      A.      .C
    //       .        .
    //       .c        a.
    //       .  . . . . . .
    //            B
    final List<double> rotatedSmallLine =
        rotateCoordinate(size.width * sides[0], 0, angles[2]);

    print(angles);
    print(sides);

    // This is the part of the code
    // where the triangle is drawn
    final Path path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(rotatedSmallLine[0], rotatedSmallLine[1])
      ..close();
    canvas.drawPath(path, _paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawTriangleFromDegrees(
      canvas: canvas,
      size: size,
      angles: [45, 45, 90],
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
