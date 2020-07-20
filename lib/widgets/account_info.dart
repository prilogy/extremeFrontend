import 'package:extreme/styles/extreme_colors.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
bool emailConfirmed;
Widget confirmation;
  @override
  Widget build(BuildContext context) {
    // TODO: add padding between texts
    emailConfirmed = true;
    emailConfirmed ? confirmation = Confirmation() : confirmation = Container(); // TODO: change to something more logic
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
            Row(
              children: <Widget>[
                Text(
                  'Email: '+ 'example@gmail.com',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                confirmation,
              ],
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
class Confirmation extends StatelessWidget {
  const Confirmation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(children: <Widget>[
        Icon(Icons.error, color: ExtremeColors.error,),
        Text('Подтвердить', style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ExtremeColors.error)),)
      ],),
      onTap: (){
        print('Email confirmation InkWell pressed');
      },
    );
  }
}