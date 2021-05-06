import 'package:extreme/helpers/color_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:flutter_inapp_purchase/modules.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SubscriptionCard extends StatelessWidget {
  final int? price;
  final String? title;
  final String? description;

  final double? aspectRatio;
  final VoidCallback? onPressed;
  final Models.SubscriptionPlan? model;
  final IAPItem? iapItem;
  final bool? isForFree;

  SubscriptionCard(
      {this.description,
      this.title,
      this.price,
      this.iapItem,
      this.aspectRatio,
      this.onPressed,
      this.isForFree = false,
      @required this.model});

  @override
  Widget build(BuildContext context) {
    var color = HexColor.fromHex(model!.color!);
    var discount =
        model!.price!.discountValue != 0 ? model!.price!.discountToString() : 0;
    var price = iapItem?.localizedPrice ?? model!.price.toString();
    var title = model!.content?.name ?? '';
    var desc = model!.content?.description ?? '';
    var loc = AppLocalizations.of(context)?.withBaseKey('subscription');
    var isSubscribed =
        StoreProvider.of<AppState>(context).state.user!.isSubscribed;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: color, width: 2)),
      child: Stack(
        children: <Widget>[
          discount != 0 && isForFree != true
              ? Saving(
                  color: color,
                  text: '${loc!.translate('discount', [discount.toString()])}')
              : Container(),
          Padding(
            padding: const EdgeInsets.all(Indents.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: Indents.sm),
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.merge(TextStyle(color: color)),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                desc,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
                Container(
                  padding: EdgeInsets.only(right: Indents.sm),
                  margin: EdgeInsets.only(left: Indents.sm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        price,
                        style: Theme.of(context).textTheme.subtitle2?.merge(
                            TextStyle(
                                fontSize: 20,
                                decoration: isForFree!
                                    ? TextDecoration.lineThrough
                                    : null)),
                      ),
                      RaisedButton(
                          color: isForFree! ? ExtremeColors.success : color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () {
                            if (!isForFree!) onPressed?.call();
                          },
                          child: Row(
                            children: <Widget>[
                              isForFree! ? Icon(Icons.check) : Container(),
                              Container(
                                child: Text(loc!.translate(isForFree!
                                    ? 'is_free'
                                    : (isSubscribed ? 'extend' : 'subscribe'))),
                              ),
                            ],
                          ))
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
  final Color? color;
  final String? text;

  const Saving({Key? key, this.color, this.text}) : super(key: key);

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
              Baseline(
                baseline: 10,
                baselineType: TextBaseline.alphabetic,
                child: Text((text ?? '').toUpperCase(),
                    style: Theme.of(context).textTheme.overline),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
