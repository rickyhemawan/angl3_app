import 'package:flutter/material.dart';

class AngleInfoContainer extends StatelessWidget {
  const AngleInfoContainer({
    Key key,
    @required this.context,
    @required this.color,
    @required this.name,
    @required this.value,
    this.isSide = false,
  }) : super(key: key);

  final BuildContext context;
  final Color color;
  final String name;
  final double value;
  final bool isSide;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Dot(
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
            child: Container(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
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
              ),
            ),
          ),
        ],
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
