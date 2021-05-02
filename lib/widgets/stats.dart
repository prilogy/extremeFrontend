import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

// Иконка + количество
class Stats extends StatelessWidget {
  final IconData icon;
  final String text;
  final double marginBetween;
  final double widgetMarginRight;
  final bool reversed;

  const Stats(
      {Key? key,
      this.icon = Icons.error,
      this.text = "",
      this.marginBetween = Indents.sm,
      this.widgetMarginRight = Indents.md,
      this.reversed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgets = [
      Container(
          margin: EdgeInsets.only(
              left: reversed ? marginBetween : 0,
              right: reversed ? 0 : marginBetween),
          child: Icon(icon)),
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            ?.merge(TextStyle(fontWeight: FontWeight.w500)),
      )
    ];

    if (reversed == true) widgets = widgets.reversed.toList();

    return Container(
      margin: EdgeInsets.only(right: widgetMarginRight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }
}
