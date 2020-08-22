import 'package:angl3_app/components/flashy_button.dart';
import 'package:angl3_app/components/info_container.dart';
import 'package:angl3_app/components/card_base.dart';
import 'package:angl3_app/components/draw_triangle_sliver_delegate.dart';
import 'package:angl3_app/components/intro_widget.dart';
import 'package:angl3_app/components/modify_angles_dialog.dart';
import 'package:angl3_app/components/option_list_tile.dart';
import 'package:angl3_app/constants.dart';
import 'package:angl3_app/models_data/triangle_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _angleAController = TextEditingController();

  Widget _appBar(BuildContext context, TriangleData triangleData) {
    return SliverPersistentHeader(
      delegate: DrawTriangleSliverDelegate(
        expandedHeight: MediaQuery.of(context).size.height / 2.5,
        triangleModel: triangleData.triangle,
        alwaysExpand: triangleData.triangle.imageOption.alwaysExpandImage,
      ),
      pinned: true,
    );
  }

  Widget _optionsSection(BuildContext context, TriangleData triangleData) {
    return CardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntroWidget(
            context: context,
            title: "Options",
            description: "This the options to modify the image.",
          ),
          OptionListTile(
            value: true,
            name: "Triangle Visibility",
            onToggle: triangleData.toggleShowTriangle,
          ),
          OptionListTile(
            value: true,
            name: "Lines Visibility",
            onToggle: triangleData.toggleShowLines,
          ),
          OptionListTile(
            value: true,
            name: "Vertices Visibility",
            onToggle: triangleData.toggleShowAngles,
          ),
          OptionListTile(
            value: false,
            name: "Always Expand Image",
            onToggle: triangleData.toggleAlwaysExpand,
          ),
          Divider(
            color: Colors.blueGrey,
            thickness: 2.0,
          ),
          Text(
            kExtraDescription,
            textAlign: TextAlign.justify,
          ),
          Divider(
            color: Colors.blueGrey,
            thickness: 2.0,
          ),
        ],
      ),
    );
  }

  double fix2Number(double val) => num.parse((val * 100).toStringAsFixed(2));

  Widget _angleSection(BuildContext context, TriangleData triangleData) {
    return CardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntroWidget(
            context: context,
            title: "Angles",
            description: kAnglesDescription,
          ),
          InfoContainer(
            context: context,
            color: Colors.limeAccent,
            name: "A Angle",
            value: triangleData.triangle.angleA,
          ),
          InfoContainer(
            context: context,
            color: Colors.lightBlueAccent,
            name: "B Angle",
            value: triangleData.triangle.angleB,
          ),
          InfoContainer(
            context: context,
            color: Colors.pinkAccent,
            name: "C Angle",
            value: triangleData.triangle.angleC,
          ),
          SizedBox(height: 8.0),
          FlashyButton(
            onTap: () async => {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TriangleData triangleData =
                        Provider.of<TriangleData>(context);
                    return ModifyAnglesDialog(
                        triangleData: triangleData,
                        angleAController: _angleAController);
                  }).then((value) => print("dialog dismissed")),
            },
            buttonName: "Modify Angles",
          ),
        ],
      ),
    );
  }

  Widget _sidesSection(BuildContext context, TriangleData triangleData) {
    return CardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntroWidget(
            context: context,
            title: "Sides",
            description: kSidesDescription,
          ),
          InfoContainer(
            context: context,
            color: Colors.red,
            colors: [
              Colors.lightBlueAccent,
              Colors.pinkAccent,
            ],
            name: "B-C Side",
            value: fix2Number(triangleData.triangle.sideA),
            isSide: true,
          ),
          InfoContainer(
            context: context,
            color: Colors.orange,
            colors: [
              Colors.yellow,
              Colors.pinkAccent,
            ],
            name: "A-C Side",
            value: fix2Number(triangleData.triangle.sideB),
            isSide: true,
          ),
          InfoContainer(
            context: context,
            color: Colors.yellow,
            colors: [
              Colors.yellow,
              Colors.lightBlueAccent,
            ],
            name: "A-B Side",
            value: fix2Number(triangleData.triangle.sideC),
            isSide: true,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TriangleData>(
          builder: (context, triangleData, child) {
            return CustomScrollView(
              slivers: <Widget>[
                _appBar(context, triangleData),
                _angleSection(context, triangleData),
                _sidesSection(context, triangleData),
                _optionsSection(context, triangleData),
              ],
            );
          },
        ),
      ),
    );
  }
}
