import 'package:angl3_app/models/triangle.dart';
import 'package:angl3_app/utils/draw_triangle_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DrawTriangle extends StatelessWidget {
  final double squareSize;
  final Triangle triangleModel;

  DrawTriangle({@required this.squareSize, @required this.triangleModel});

  @override
  Widget build(BuildContext context) {
    final double phoneHeight = MediaQuery.of(context).size.height;
    double getHighestHeight() =>
        kToolbarHeight * 3 > squareSize ? kToolbarHeight * 3 : squareSize;
    return Container(
      height: phoneHeight / 2.5,
      alignment: Alignment.center,
      child: CustomPaint(
        size: Size.square(getHighestHeight() / 3.5),
        painter: DrawTrianglePainter(
          triangleModel: triangleModel,
        ),
      ),
    );
  }
}
