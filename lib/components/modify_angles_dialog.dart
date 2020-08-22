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
      chips.add(AngleChip(
        color: colors[i],
        degree: angles[i],
        onDeleted: () => triangleData.removeOneAngle(angles[i]),
      ));
    }
    return chips;
  }

  Widget submitModification(BuildContext context) {
    if (!triangleData.isModifyAnglePerfect) return SizedBox();
    return PlainButton(
      color: Colors.green,
      label: "Submit Modification",
      onTap: () {
        triangleData.onModifyAnglesSubmitted();
        Navigator.pop(context);
      },
    );
  }

  Widget fillOne(BuildContext context) {
    if (!triangleData.isFillOne) return SizedBox();
    return PlainButton(
      label: "Fill the Last One",
      color: Colors.orange,
      onTap: triangleData.onFillOneSubmitted,
    );
  }

  Widget fillTwo(BuildContext context) {
    if (!triangleData.isFillTwo) return SizedBox();
    return PlainButton(
      label: "Fill the Other Two",
      color: Colors.blue,
      onTap: triangleData.onFillTwoSubmitted,
    );
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
                  color: triangleData.isModifyAnglePerfect
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
                submitModification(context),
                fillOne(context),
                fillTwo(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlainButton extends StatelessWidget {
  const PlainButton({
    Key key,
    @required this.label,
    @required this.color,
    this.onTap,
  }) : super(key: key);

  final String label;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
            color: color,
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: color.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
