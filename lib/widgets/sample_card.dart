import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

class SampleCard extends StatelessWidget with IndentsMixin {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Models.Image image;
  final String title;
  final String body;
  final Models.Price price;
  final bool isForFree;

  final double height;

  SampleCard(
      {this.padding,
      this.margin,
      this.image,
      this.height = 80,
      this.price,
      this.title,
      this.body,
      this.isForFree = false});

  @override
  Widget build(BuildContext context) {
    return withIndents(
        child: Container(
      height: height,
      padding: EdgeInsets.all(Indents.md),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).canvasColor),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: Indents.md),
            child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: ExtremeColors.primary,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image?.path ?? ''),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                )),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Text(body)
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      price.toString(),
                      style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(
                              decoration: isForFree
                                  ? TextDecoration.lineThrough
                                  : null)),
                    ),
                    isForFree
                        ? Text(AppLocalizations.of(context)
                            .translate('subscription.is_free'))
                        : Container()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
