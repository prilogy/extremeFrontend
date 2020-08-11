import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Confirmation extends StatelessWidget {
  Confirmation({Key key}) : super(key: key);
  bool pending = true;
  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
      appBar: AppBar(title: Text('Подтверждение email')),
      builder: (context) => [
        BlockBaseWidget(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.mail_outline,
                size: 100,
              ),
              Text(
                'Введие код, который мы отправили на ваш Email example@gmail.com',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              TextField(
                decoration: new InputDecoration(labelText: "Enter your number"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
              ),
              RaisedButton(
                onPressed: () {
                  print('hi there');
                },
                child: Text('Подтвердить'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
