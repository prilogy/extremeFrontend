import 'package:extreme/helpers/app_builder.dart';
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

  AccountInfo();

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  bool edit = false;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = StoreProvider.of<AppState>(context).state.user;
    var confirmation = !user.emailVerified ? ConfirmationSign() : Container();
    _nameController.text = user.name;
    _emailController.text = user.email;

    if (!edit)
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
                      'С Extreme Insiders с ' +
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

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Имя', icon: Icon(Icons.person)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Введите текст самфинг';
                }

                return null;
              },
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
                Container(
                  margin: EdgeInsets.only(right: Indents.sm),
                  child: FlatButton(
                    color: Colors.transparent,
                    child: Text(
                      'Отменить',
                    ),
                    onPressed: () {
                      setState(() {
                        edit = false;
                      });
                    },
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).colorScheme.primary,
                  child: Text(
                    'Сохранить',
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) return null;
                    await Api.User.edit(
                        name: _nameController.text != user.name
                            ? _nameController.text
                            : null,
                        email: _emailController.text != user.email
                            ? _emailController.text
                            : null);

                    await Api.User.refresh(true, true);
                    setState(() {
                      edit = false;
                    });
                  },
                )
              ],
            )
          ],
        ));
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
