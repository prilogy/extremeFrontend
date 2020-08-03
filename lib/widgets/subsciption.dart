import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

import 'block_base_widget.dart';

class Subscription extends StatelessWidget with IndentsMixin {
  final Color color;
  final int price;
  final String title;
  final String description;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double aspectRatio;

  Subscription(
      {this.color,
      this.description,
      this.title,
      this.price,
      this.padding,
      this.margin,
      this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    Widget _saving;
    price != 200
        ? _saving = Saving(
            color: color,
          )
        : _saving = Container();
    return withIndents(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: color, width: 2)),
        child: Stack(
          children: <Widget>[
            // Виджет с казанием экономии
            _saving,
            Padding(
              padding: const EdgeInsets.all(Indents.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: Indents.sm),
                          child: Text(
                            'Подписка на ' + title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ]),
                  Padding(
                    padding: EdgeInsets.only(right: Indents.sm),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              print(price.toString() +
                                  '₽ subscription button pressed');
                            },
                            child: Text('Продлить'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Saving extends StatelessWidget {
  final Color color;

  const Saving({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: Indents.sm, vertical: Indents.sm / 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(5)),
              color: color),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: Indents.sm / 2),
                child: Icon(
                  Icons.offline_bolt,
                  size: 16,
                ),
              ),
              // Измениние baseline будет двигать строку "Экономия ..." по вертикальной оси
              Baseline(
                baseline: 10,
                baselineType: TextBaseline.alphabetic,
                child: Text('ЭКОНОМИЯ 400₽', //TODO: исправить на нужную цену
                    style: Theme.of(context).textTheme.overline),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
