import 'package:extreme/models/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:flutter/material.dart';

class PayCard extends StatelessWidget {
  final Price price;
  final String name;
  final String description;
  const PayCard({Key key, this.price, this.name, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlockBaseWidget(
      child: Container(
        margin: EdgeInsets.only(top: Indents.md),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white, width: 2)),
        child: Row(
          children: <Widget>[
            Column(children: <Widget>[
              Text(name)
            ],),
            Column(),
          ],
        ),
      ),
    );
  }
}
