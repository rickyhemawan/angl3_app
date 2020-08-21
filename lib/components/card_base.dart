import 'package:flutter/material.dart';

class CardBase extends StatelessWidget {
  final Widget child;
  CardBase({@required this.child});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}
