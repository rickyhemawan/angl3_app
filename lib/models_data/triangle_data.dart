import 'package:angl3_app/models/triangle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TriangleData with ChangeNotifier, DiagnosticableTreeMixin {
  Triangle triangle;
  double expandedHeight;

  // Modify Angles Variables
  List<double> modifyAngles;

  TriangleData() {
    triangle = Triangle(
      angleA: 50,
      angleB: 70,
      angleC: 60,
    );
    modifyAngles = [];
  }

  // Image toggle Functions
  void toggleShowTriangle(val) {
    triangle.imageOption.toggleShowTriangle();
    notifyListeners();
  }

  void toggleShowLines(val) {
    triangle.imageOption.toggleShowLines();
    notifyListeners();
  }

  void toggleShowAngles(val) {
    triangle.imageOption.toggleShowAngles();
    notifyListeners();
  }

  void toggleAlwaysExpand(val) {
    triangle.imageOption.toggleAlwaysExpand();
    notifyListeners();
  }

  // Modify Angles Functions

  double stringToDouble1Decimal(String val) {
    int starting = (double.parse(val) * 10).toInt();
    return starting / 10;
  }

  double get modifyAnglesSum {
    List<double> val = [];
    val.addAll(modifyAngles);
    return val.length == 0
        ? 0
        : modifyAngles.reduce((value, element) => value + element);
  }

  bool get isModifyAnglePerfect =>
      modifyAnglesSum == 180 && modifyAngles.length == 3;

  bool get isFillOne => modifyAnglesSum < 180 && modifyAngles.length == 2;
  bool get isFillTwo => modifyAnglesSum < 180 && modifyAngles.length == 1;

  void onAngleSubmitted({
    String result,
    TextEditingController controller,
    Function(String msg) onMsgReceived,
  }) {
    double parsedResult = double.parse(result);
    if (parsedResult >= 180) {
      onMsgReceived("Number Cannot be higher or equal than 180");
      return;
    }

    if (stringToDouble1Decimal(result) < parsedResult) {
      onMsgReceived("Please don't use more than 1 decimal digits");
      return;
    }

    if (modifyAngles.length > 2) {
      onMsgReceived(
          "3 Angles have been inputted, please delete one to input another Angle.");
      return;
    }

    controller.clear();
    double x = stringToDouble1Decimal(result);
    modifyAngles.add(x);
    notifyListeners();
  }

  void clearModifyAnglesDialog() {
    modifyAngles = [];
    notifyListeners();
  }

  void onModifyAnglesSubmitted() {
    triangle.setAnglesFromArray(modifyAngles);
    triangle.calculateSides();
    clearModifyAnglesDialog();
  }

  void onFillOneSubmitted() {
    modifyAngles.add(180 - modifyAnglesSum);
    notifyListeners();
  }

  void onFillTwoSubmitted() {
    double firstHalf =
        stringToDouble1Decimal(((180 - modifyAnglesSum) / 2).toString());
    double wtfIsThis =
        ((stringToDouble1Decimal(((180 - modifyAnglesSum) * 10).toString())));
    bool isOdd = wtfIsThis.toInt().isOdd;
    modifyAngles.add(firstHalf);
    print("WTF $wtfIsThis, isOdd $isOdd");
    if (isOdd)
      modifyAngles.add(firstHalf + 0.1);
    else
      modifyAngles.add(firstHalf);

    notifyListeners();
  }

  void removeOneAngle(double val) {
    modifyAngles.remove(val);
    notifyListeners();
  }
}
