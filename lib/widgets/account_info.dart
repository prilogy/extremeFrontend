import 'package:extreme/styles/extreme_colors.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: add padding between texts
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            Text(
              'Имя Фамилия',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text('С Exteme Insiders с 13.03.2019',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .merge(TextStyle(color: ExtremeColors.base70[200]))),
            Text(
              'Email: example@gmail.com',
              style: Theme.of(context).textTheme.bodyText2,
            )
          ]),
          Column(children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Color.fromRGBO(182, 181, 189, 1),
              ),
              tooltip: 'Редактировать',
              onPressed: () {},
            ),
          ])
        ],
      ),
    );
  }
}
