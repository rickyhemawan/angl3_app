import 'package:flutter/material.dart';

class AngleChip extends StatelessWidget {
  final Color color;
  final double degree;
  final void Function() onDeleted;

  const AngleChip({
    Key key,
    @required this.color,
    @required this.degree,
    @required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      deleteIcon: Icon(
        Icons.cancel,
        color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      ),
      onDeleted: onDeleted,
      label: Text(
        degree.toStringAsFixed(1) + "°",
        style: Theme.of(context).textTheme.headline6.copyWith(
              color:
                  color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            ),
      ),
      padding: EdgeInsets.all(4.0),
      backgroundColor: color,
    );
  }
}
