import 'package:flutter/material.dart';

import 'flutter_animation_progress_bar.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    Key key,
    @required this.context,
    @required this.name,
    @required this.value,
    this.color,
    this.colors,
    this.isSide = false,
  }) : super(key: key);

  final BuildContext context;
  final Color color;
  final List<Color> colors;
  final String name;
  final double value;
  final bool isSide;

  // This style is not used
  Widget style1() {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        color: color,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text: TextSpan(
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: color.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                ),
            children: <TextSpan>[
              TextSpan(text: "$value"),
              TextSpan(text: isSide ? "%" : "°"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          colors != null
              ? LongDot(
                  colors: colors,
                )
              : Dot(
                  color: color,
                ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 1,
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            flex: 1,
            child: FAProgressBar(
              direction: Axis.horizontal,
              currentValue: value,
              maxValue: isSide ? 100 : 180,
              backgroundColor: null,
              progressColor: color,
              displayText: isSide ? "%" : "°",
            ),
          ),
        ],
      ),
    );
  }
}

class LongDot extends StatelessWidget {
  final List<Color> colors;

  LongDot({this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 18,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(),
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final Color color;

  const Dot({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
