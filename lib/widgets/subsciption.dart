import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

class Subscription extends StatelessWidget {
  final Color color;
  final int price;
  final String title;
  final String description;
  Subscription({this.color, this.description, this.title, this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Indents.sm, bottom: Indents.sm),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: color, width: 2)),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(5)),
              color: color
            ),
            child: Text('ЭКОНОМИЯ 400₽'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                Text(
                  'Подписка на ' + title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.caption,
                )
              ]),
              Column(
                children: <Widget>[
                  Text(
                    price.toString() + '₽',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .merge(TextStyle(fontSize: 24)),
                  ),
                  RaisedButton(
                      color: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        print(
                            price.toString() + '₽ subscription button pressed');
                      },
                      child: Text('Продлить'))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
