import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

// Иконка + количество
class Stats extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconMarginRight;
  final double widgetMarginRight;
  const Stats({Key key, this.icon, this.text, this.iconMarginRight = Indents.sm, this.widgetMarginRight = Indents.md})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: widgetMarginRight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: iconMarginRight), child: Icon(icon)),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .merge(TextStyle(fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }
}
