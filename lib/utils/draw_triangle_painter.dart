import 'package:angl3_app/models/triangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DrawTrianglePainter extends CustomPainter {
  Triangle triangleModel;

  DrawTrianglePainter({
    this.triangleModel,
  });

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
        triangleModel.getRotatedSmallLine(size.width);

    // This is the part of the code
    // where the triangle is drawn
    if (triangleModel.imageOption.showTriangle) {
      final Path path = Path()
        ..moveTo(size.width, 0)
        ..lineTo(0, 0)
        ..lineTo(rotatedSmallLine[0], rotatedSmallLine[1])
        ..close();
      canvas.drawPath(path, _paint);
    }
  }

  void drawLineFromDegrees({
    @required Canvas canvas,
    @required Size size,
    @required List<double> angles,
  }) {
    Paint _paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final List<double> rotatedSmallLine =
        triangleModel.getRotatedSmallLine(size.width);

    // This is the part of the code
    // where the triangle is drawn
    final Path path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(rotatedSmallLine[0], rotatedSmallLine[1])
      ..close();
    canvas.drawPath(path, _paint);
  }

  void drawVertexFromDegrees({
    @required Canvas canvas,
    @required Size size,
    @required List<double> angles,
  }) {
    Paint _paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    Paint _paint1 = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.fill;

    Paint _paint2 = Paint()
      ..color = Colors.lightBlueAccent
      ..style = PaintingStyle.fill;

    final List<double> rotatedSmallLine =
        triangleModel.getRotatedSmallLine(size.width);

    canvas.drawCircle(Offset(size.width, 0), size.width / 20, _paint);
    canvas.drawCircle(Offset(0, 0), size.width / 20, _paint1);
    canvas.drawCircle(Offset(rotatedSmallLine[0], rotatedSmallLine[1]),
        size.width / 20, _paint2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Modifying canvas so it always start at the
    // bottom left of canvas instead of top right
    canvas
      ..translate(0, size.height)
      ..scale(1, -1);

    print(triangleModel.imageOption.showTriangle);
    if (triangleModel.imageOption.showTriangle) {
      drawTriangleFromDegrees(
        canvas: canvas,
        size: size,
        angles: triangleModel.angles,
      );
    }
    if (triangleModel.imageOption.showLines) {
      print("this code triggered");
      drawLineFromDegrees(
        canvas: canvas,
        size: size,
        angles: triangleModel.angles,
      );
    }
    if (triangleModel.imageOption.showAngles) {
      drawVertexFromDegrees(
        canvas: canvas,
        size: size,
        angles: triangleModel.angles,
      );
    }
//    print("triangleModel.ImageOption = ${triangleModel.imageOption}");
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is DrawTrianglePainter) {
      print("triggered");
      return oldDelegate.triangleModel.imageOption !=
          oldDelegate.triangleModel.imageOption;
    }
    return false;
  }
}
