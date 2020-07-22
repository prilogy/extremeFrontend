import 'package:extreme/styles/extreme_colors.dart';
import 'package:flutter/material.dart';

class SocialAccount extends StatelessWidget {
  final String name;
  final bool isConnected;

  SocialAccount({this.name, this.isConnected});

  @override
  Widget build(BuildContext context) {
    var text = isConnected ? 'ОТКЛЮЧИТЬ' : 'ОТКЛЮЧИТЬ';
    var textColor = isConnected ? ExtremeColors.error : ExtremeColors.success;

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
