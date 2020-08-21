import 'package:angl3_app/utils/draw_triangle_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DrawTriangle extends StatefulWidget {
  @override
  _DrawTriangleState createState() => _DrawTriangleState();

  final double squareSize;

  DrawTriangle({@required this.squareSize});
}

class _DrawTriangleState extends State<DrawTriangle> {
  @override
  Widget build(BuildContext context) {
    final double phoneHeight = MediaQuery.of(context).size.height;
    double getHighestHeight() => kToolbarHeight * 3 > widget.squareSize
        ? kToolbarHeight * 3
        : widget.squareSize;
    return Container(
      height: phoneHeight / 2.5,
      alignment: Alignment.center,
      child: CustomPaint(
        size: Size.square(getHighestHeight() / 3.5),
        painter: DrawTrianglePainter(),
      ),
    );
  }
}
