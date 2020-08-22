import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

import 'image_option.dart';

class Triangle {
  // Where all of the sides length percentage will go
  // middle percentage of triangle will always be 1
  // which indicate that the value of the second sides is 100% of size.width
  // So it have starting point of 'a/SinA' which is essential for the 'Sin Rule'
  final List<double> baseSides = [0, 1.0, 0];

  ImageOption imageOption;

  double angleA;
  double angleB;
  double angleC;

  double sideA; // equal to side b-c
  double sideB; // equal to side a-c
  double sideC; // equal to side a-b

  Triangle({
    double angleA,
    double angleB,
    double angleC,
  }) {
    this.angleA = angleA;
    this.angleB = angleB;
    this.angleC = angleC;
    this.sideA = baseSides[0];
    this.sideB = baseSides[1];
    this.sideC = baseSides[2];
    this.imageOption = ImageOption();
    calculateSides();
  }

  List<double> get sides => [sideA, sideB, sideC];

  List<double> get angles {
    List<double> sortedA = [angleA, angleB, angleC];
    sortedA.sort();
    return sortedA;
  }

  double get anglesSum => angles.reduce((value, element) => value + element);

  bool get isAngleOdd => anglesSum == 180.0;

  void setSidesFromArray(List<double> sides) {
    sides.sort();
    sideA = sides[0];
    sideB = sides[1];
    sideC = sides[2];
  }

  void setAnglesFromArray(List<double> anglesArray) {
    anglesArray.sort();
    angleA = anglesArray[0];
    angleB = anglesArray[1];
    angleC = anglesArray[2];
  }

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

  void calculateSides() {
    List<double> angleArray = angles;
    List<double> sidesArray = sides;

    if (angleArray[2] > 90) sidesArray[1] = 0.75;
    if (angleArray[2] > 115) sidesArray[1] = 0.5;
    if (angleArray[2] > 145) sidesArray[1] = 0.25;

//    print("Sides == $sides");
//    print("sidesArray == $sidesArray");
//    print("angles == $angles");

    // Assigning all of the other sides according to their length
    for (int i = 0; i < 3; i += 2)
      sidesArray[i] =
          calculateSinRule(angleArray[i], angleArray[1], sidesArray[1]);

    setSidesFromArray(sidesArray);
    setAnglesFromArray(angleArray);
  }

  List<double> getRotatedSmallLine(double squareSize) {
    calculateSides();
    return rotateCoordinate(squareSize * sides[0], 0, angles[2]);
  }
}
