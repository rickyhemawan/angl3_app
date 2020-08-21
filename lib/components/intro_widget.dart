import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    Key key,
    @required this.context,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
