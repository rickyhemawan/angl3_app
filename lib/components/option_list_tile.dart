import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class OptionListTile extends StatelessWidget {
  final String name;
  final bool value;
  final Function(bool val) onToggle;

  const OptionListTile({
    Key key,
    @required this.name,
    @required this.value,
    @required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          FlutterSwitch(
            width: 50.0,
            height: 22.0,
            valueFontSize: 10.0,
            toggleSize: 18.0,
            value: value,
            borderRadius: 12.0,
            onToggle: onToggle,
          ),
        ],
      ),
    );
  }
}
