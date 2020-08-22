import 'package:angl3_app/models/triangle.dart';
import 'package:flutter/material.dart';
import 'draw_triangle.dart';

class DrawTriangleSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Triangle triangleModel;
  final bool alwaysExpand;

  DrawTriangleSliverDelegate({
    @required this.expandedHeight,
    @required this.triangleModel,
    this.alwaysExpand = false,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double appBarSize = alwaysExpand
        ? expandedHeight * 2.5
        : (expandedHeight - shrinkOffset) * 2.5;
    final int flexFactor = ((2 - appBarSize / expandedHeight) * 15).round();
    print(flexFactor);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(3.0),
          bottomRight: Radius.circular(
            3.0,
          )),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xff184e68),
              Color(0xff57ca85),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 10,
              child: Container(
                child: DrawTriangle(
                  triangleModel: triangleModel,
                  squareSize: appBarSize,
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: flexFactor > 0
                  ? Text(
                      "Angl3",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  : SizedBox(),
            ),
            Expanded(
              flex: flexFactor > 0 ? flexFactor : 0,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => alwaysExpand ? expandedHeight : kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
