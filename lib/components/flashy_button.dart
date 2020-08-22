import 'package:flutter/material.dart';

class FlashyButton extends StatelessWidget {
  final Function onTap;
  final String buttonName;

  const FlashyButton({
    Key key,
    @required this.onTap,
    @required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blueAccent,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xff184e68),
                Color(0xff57ca85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        child: Text(
          buttonName,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
