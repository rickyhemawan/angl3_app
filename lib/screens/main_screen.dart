import 'package:angl3_app/components/angle_info_container.dart';
import 'package:angl3_app/components/card_base.dart';
import 'package:angl3_app/components/draw_triangle_sliver_delegate.dart';
import 'package:angl3_app/components/intro_widget.dart';
import 'package:angl3_app/constants.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _appBar() {
    return SliverPersistentHeader(
      delegate: DrawTriangleSliverDelegate(
        MediaQuery.of(context).size.height / 2.5,
      ),
      pinned: true,
    );
  }

  Widget _angleSection() {
    return CardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntroWidget(
            context: context,
            title: "Angles",
            description: kAnglesDescription,
          ),
          AngleInfoContainer(
            context: context,
            color: Colors.limeAccent,
            name: "Angle a",
            value: 60.5,
          ),
          AngleInfoContainer(
            context: context,
            color: Colors.orange,
            name: "Angle b",
            value: 60.5,
          ),
          AngleInfoContainer(
            context: context,
            color: Colors.black,
            name: "Angle c",
            value: 59,
          ),
          AngleInfoContainer(
            context: context,
            color: Colors.green,
            name: "Sum",
            value: 180,
          ),
        ],
      ),
    );
  }

  Widget _sidesSection() {
    return CardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntroWidget(
            context: context,
            title: "Sides",
            description: kSidesDescription,
          ),
          AngleInfoContainer(
            context: context,
            color: Colors.red,
            name: "Side ab",
            value: 100,
            isSide: true,
          ),
          AngleInfoContainer(
            context: context,
            color: Colors.orange,
            name: "Side bc",
            value: 100,
            isSide: true,
          ),
          AngleInfoContainer(
            context: context,
            color: Colors.yellow,
            name: "Side ac",
            value: 100,
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
        child: CustomScrollView(
          slivers: <Widget>[
            _appBar(),
            _angleSection(),
            _sidesSection(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
