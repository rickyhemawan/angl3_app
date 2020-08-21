import 'package:flutter/material.dart';
import 'draw_triangle.dart';

class DrawTriangleSliverDelegate extends SliverPersistentHeaderDelegate {
  final expandedHeight;

  DrawTriangleSliverDelegate(this.expandedHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double appBarSize = (expandedHeight - shrinkOffset) * 2.5;
    final int flexFactor = ((2 - appBarSize / expandedHeight) * 15).round();
    print(flexFactor);
    return Container(
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
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
