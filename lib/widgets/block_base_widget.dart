import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

class BlockBaseWidget extends StatelessWidget with IndentsMixin {
  final Widget child;
  final String header;

  final EdgeInsetsGeometry headerPadding;

  BlockBaseWidget(
      {this.child,
      this.header = "",
      this.headerPadding = const EdgeInsets.all(0),
      EdgeInsetsGeometry padding =
          const EdgeInsets.symmetric(horizontal: Indents.md),
      EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: Indents.lg)}) {
    this.margin = margin;
    this.padding = padding;
  }

  BlockBaseWidget.forScrollingViews(
      {this.child,
      this.header,
      this.headerPadding = const EdgeInsets.only(left: Indents.md),
      EdgeInsetsGeometry padding =
          const EdgeInsets.all(0),
      EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: Indents.lg)}) {
    this.margin = margin;
    this.padding = padding;
  }

  @override
  Widget build(BuildContext context) {
    return withIndents(
      child: Column(
        children: <Widget>[
          if (header != "")
            Container(
                alignment: Alignment.topLeft,
                padding: headerPadding,
                margin: EdgeInsets.only(bottom: Indents.md),
                child:
                    Text(header, style: Theme.of(context).textTheme.headline6)),
          child
        ],
      ),
    );
  }
}
