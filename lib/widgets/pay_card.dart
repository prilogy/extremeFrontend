import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';

class PayCard extends StatelessWidget {
  final Price price;
  final bool isBought;
  final VoidCallback onBuy;
  final MainAxisAlignment alignment;

  const PayCard({Key key, @required this.price, @required this.isBought, this.onBuy, this.alignment = MainAxisAlignment.spaceAround})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context).withBaseKey("pay_card");

    return  Row(
        mainAxisAlignment: alignment,
        children: <Widget>[
          if(!isBought)
            Flexible(
            child: Container(
                padding: EdgeInsets.only(right: Indents.md),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        loc.translate('info'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                )),
          ),
          Column(
            children: <Widget>[
              !isBought
                  ? Text(
                      price?.toString() ?? 'Error',
                      style:
                          Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                fontSize: 24,
                              )),
                    )
                  : Container(),
              isBought
                  ?  Row(
                        children: <Widget>[
                          Icon(
                            Icons.done,
                            color: ExtremeColors.success,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: Indents.sm, right: Indents.md),
                              child: Text(loc.translate('owned'), style: TextStyle(color: ExtremeColors.success),))
                        ],
                      )
                  : RaisedButton(
                      color: Theme.of(context).colorScheme.primary,
                      child: Text(loc.translate('buy')),
                      onPressed: () {
                        onBuy?.call();
                      })
            ],
          ),
        ],
    );
  }
}
