import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;

class Subscription extends StatelessWidget {
  final int price;
  final String title;
  final String description;

  final double aspectRatio;
  final VoidCallback onPressed;
  final Models.SubscriptionPlan model;

  Subscription(
      {this.description,
      this.title,
      this.price,
      this.aspectRatio,
      this.onPressed,
      @required this.model});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (model?.id ?? 4) {
      case 1:
        color = ExtremeColors.warning;
        break;
      case 2:
        color = ExtremeColors.success;
        break;
      case 3:
        color = ExtremeColors.primary;
        break;
      default:
        color = ExtremeColors.error;
    }
    Models.Currency currency;
    switch (model?.price?.currency?.key ?? 'NOT') {
      case 'RUB':
        currency = Models.Currency.RUB;
        break;
      case 'USD':
        currency = Models.Currency.USD;
        break;
      case 'EUR':
        currency = Models.Currency.EUR;
        break;
      default:
        currency = Models.Currency(key: 'NOT', symbol: 'NOT', name: 'Nothing');
    }

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: color, width: 2)),
        child: Stack(
          children: <Widget>[
            Saving(color: color),
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
                            model?.content?.name ??
                                'Неопределёный промежуток времени',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          model?.content?.description ??
                              'Описание плана подсписки',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ]),
                  Container(
                    padding: EdgeInsets.only(right: Indents.sm),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          model?.price?.value.toString()+ currency?.symbol ??
                              '777 Руб',
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
                              onPressed();
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
    );
  }
}

/// Создаёт плашку с указанием экономии
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
