import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;

class AccountInfo extends StatelessWidget {
  final User user;
  final bool edit;
  AccountInfo({this.user, this.edit = false});

  @override
  Widget build(BuildContext context) {
    Widget confirmation;
    !user.emailVerified
        ? confirmation = Confirmation()
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
                  icon: Icon(
                Icons.edit,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
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
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: TextField(
                      controller: _nameController,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .merge(TextStyle(height: 1.6)),
                    ),
                  ),
                  Text(
                      'С Exteme Insiders с ' +
                          HelperMethods.DateToString(user.dateSignUp),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .merge(TextStyle(color: ExtremeColors.base70[200]))),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: _emailController,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ]),
            Column(children: <Widget>[
              IconButton(
                  icon: Icon(
                Icons.done,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
              )),
            ])
          ],
        ),
      );
    }
  }
}

class Confirmation extends StatelessWidget {
  const Confirmation({Key key}) : super(key: key);

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
          print('Email confirmation InkWell pressed');
        },
      ),
    );
  }
}
