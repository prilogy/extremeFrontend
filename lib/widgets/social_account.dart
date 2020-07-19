import 'package:extreme/styles/extreme_colors.dart';
import 'package:flutter/material.dart';

class SocialAccount extends StatelessWidget {
  final String name;
  String text;
  Color textColor;
  final bool isConnected;
  SocialAccount({this.name, this.isConnected});
  @override
  Widget build(BuildContext context) {
    if (isConnected) {
      textColor = ExtremeColors.error;
      text = 'ОТКЛЮЧИТЬ';
    } else {
      textColor = ExtremeColors.success;
      text = 'ПОДКЛЮЧИТЬ';
    }
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.warning,
              size: 40,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        RaisedButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          textColor: textColor,
          onPressed: () {
            print('Social account button pressed');
          },
          child: Text(text),
        )
      ],
    ));
  }
}
