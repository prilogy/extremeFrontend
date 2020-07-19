import 'package:flutter/material.dart';

class SocialAccount extends StatelessWidget {
  final String name;
  SocialAccount({this.name});
  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            print('Social account button pressed');
          },
          child: Text('Подключить'),
        )
      ],
    ));
  }
}
