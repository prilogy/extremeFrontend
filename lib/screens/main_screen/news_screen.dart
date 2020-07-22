import 'package:extreme/helpers/interfaces.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget implements IWithNavigatorKey {
  Key navigatorKey;

  NewsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.red,
          height: 50.0,
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          shrinkWrap: true,
          children: <Widget>[
            Container(
              child: Text("ss"),
            )
          ],
        )
      ],
    );
  }
}
