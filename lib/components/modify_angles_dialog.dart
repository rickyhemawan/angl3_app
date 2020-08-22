import 'package:angl3_app/models_data/triangle_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'angle_chip.dart';
import 'info_container.dart';

class ModifyAnglesDialog extends StatelessWidget {
  const ModifyAnglesDialog({
    Key key,
    @required this.triangleData,
    @required TextEditingController angleAController,
  })  : _angleAController = angleAController,
        super(key: key);

  final TriangleData triangleData;
  final TextEditingController _angleAController;

  void onMsgReceived(String msg) {
    print("msg trigger => ${triangleData.modifyAngles}");
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
  }

  List<Widget> angleChips(List<double> angles) {
    print("angleChipsTriggered");
    List<Color> colors = [
      Colors.yellowAccent,
      Colors.lightBlueAccent,
      Colors.pinkAccent,
    ];
    List<Widget> chips = [];
    for (int i = 0; i < angles.length; i++) {
      chips.add(AngleChip(color: colors[i], degree: angles[i]));
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "Modify Angles",
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 16.0),
                InfoContainer(
                  context: context,
                  color: triangleData.isModifyAnglesSum180
                      ? Colors.green
                      : Colors.red,
                  name: "Sum",
                  value: triangleData.modifyAnglesSum,
                ),
                Wrap(
                  spacing: 10.0,
                  alignment: WrapAlignment.start,
                  children: angleChips(triangleData.modifyAngles),
                ),
                SizedBox(height: 16.0),
                TextField(
                  maxLength: 5,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: "Type Angle here (max 1 digit behind .)",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  controller: _angleAController,
                  onSubmitted: (result) => triangleData.onAngleSubmitted(
                    controller: _angleAController,
                    result: result,
                    onMsgReceived: onMsgReceived,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
