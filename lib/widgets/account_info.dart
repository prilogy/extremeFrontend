import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';

class AccountInfo extends StatefulWidget {
  User user;
  AccountInfo({this.user});

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  bool edit = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: user всегда рисуется из widget.user, который не обновляется. Нужно добавить изменение user вместо с состоянием
    User user = widget.user;
    Widget confirmation;
    !user.emailVerified
        ? confirmation = ConfirmationSign()
        : confirmation = Container(); // TODO: change to something more logic
    if (!edit) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .merge(TextStyle(height: 1.6)),
                  ),
                  Text(
                      'С Exteme Insiders с ' +
                          HelperMethods.DateToString(user.dateSignUp),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .merge(TextStyle(color: ExtremeColors.base70[200]))),
                  Row(
                    children: <Widget>[
                      Text(
                        'Email: ' + user.email,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      confirmation,
                    ],
                  )
                ]),
            Column(children: <Widget>[
              IconButton(
                  onPressed: () {
                    setState(() {
                      edit = !edit;
                    });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.6),
                  )),
            ])
          ],
        ),
      );
    } else {
      TextEditingController _nameController = TextEditingController();
      _nameController.text = user.name;
      TextEditingController _emailController = TextEditingController();
      _emailController.text = user.email;
      return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'Имя', icon: Icon(Icons.person)),
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите текст самфинг';
                  }
                  if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                      .hasMatch(value)) return 'Неправильный формат email';
                  return null;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.alternate_email),
                    hintText: 'example@gmail.com',
                    labelText: 'Email'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    color: Theme.of(context).colorScheme.primary,
                    child: Text(
                      'Сохранить',
                    ),
                    onPressed: () async {
                      var _user = await Api.User.edit(
                          user.name != _nameController.text
                              ? _nameController.text
                              : null,
                          user.email != _emailController.text
                              ? _emailController.text
                              : null);
                      _user.token = user.token;
                      store.dispatch(SetUser(_user));
                      widget.user = _user;
                      setState(() {
                        edit = !edit;
                      });
                    },
                  )
                ],
              )
            ],
          ));
    }
  }
}

class ConfirmationSign extends StatelessWidget {
  const ConfirmationSign({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Indents.md),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: Indents.sm),
              child: Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            Text(
              'Подтвердить',
              style: Theme.of(context).textTheme.caption.merge(TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  )),
            )
          ],
        ),
        onTap: () {
          Api.User.confirmEmailRequset();
          Navigator.of(context, rootNavigator: true).pushNamed('/confirmation');
        },
      ),
    );
  }
}
