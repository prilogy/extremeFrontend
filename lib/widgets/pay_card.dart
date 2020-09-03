import 'package:extreme/models/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:flutter/material.dart';

class PayCard extends StatelessWidget {
  final Price price;
  final String name;
  final String description;
  const PayCard({Key key, this.price, this.name, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlockBaseWidget(
      child: Container(
        margin: EdgeInsets.only(top: Indents.md),
        padding: EdgeInsets.symmetric(vertical: Indents.md),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                color: Theme.of(context).colorScheme.error, width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('This content requires \n additional payment'),
            Column(
              children: <Widget>[
                Text(
                  price?.toString() ?? 'Free',
                  style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                        fontSize: 24,
                      )),
                ),
                RaisedButton(
                    color: Theme.of(context).colorScheme.error,
                    child: Text('Купить'),
                    onPressed: () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
