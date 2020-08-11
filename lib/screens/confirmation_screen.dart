import 'package:extreme/store/main.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter_redux/flutter_redux.dart';

class Confirmation extends StatelessWidget {
  Confirmation({Key key}) : super(key: key);
  bool pending = true;
  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    TextEditingController _controller = TextEditingController();
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
                controller: _controller,
                decoration: new InputDecoration(labelText: "Enter your number"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
              ),
              RaisedButton(
                onPressed: () async {
                  var response = await Api.User.confirmEmailAttempt(
                      int.parse(_controller.text));
                  if (response.statusCode == 200) {
                    store.state.user.emailVerified = true;
                    print('Email verified!');
                  }else print('Somth  is wrong. statuscode: ' + response.statusCode.toString());
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
