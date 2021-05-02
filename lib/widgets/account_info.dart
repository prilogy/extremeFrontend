import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:extreme/store/main.dart';

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
    final loc = AppLocalizations.of(context)?.withBaseKey('account_screen');

    var user = StoreProvider.of<AppState>(context).state.user;

    _nameController.text = user?.name ?? '';
    _emailController.text = user?.email ?? '';

    if (!edit)
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              user?.name != null
                  ? Text(
                      user?.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.merge(TextStyle(height: 1.6)),
                    )
                  : Container(),
              Text(
                  loc!.translate("duration") +
                      HelperMethods.dateToString(user!.dateSignUp!),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.merge(TextStyle(color: ExtremeColors.base70[200]))),
              user.email != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          'Email: ' + (user.email ?? ''),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        !user.emailVerified! ? ConfirmationSign() : Container(),
                      ],
                    )
                  : InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: Indents.sm),
                            child: Icon(
                              Icons.error,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          Text(
                            loc!.translate("no_email_hint"),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.merge(TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                )),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          edit = !edit;
                        });
                      },
                    ),
              user.hasPassword == false && user.email != null
                  ? InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: Indents.sm),
                            child: Icon(
                              Icons.error,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          Text(
                            loc!.translate("no_password_hint"),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.merge(TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                )),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed('/reset_pass');
                      },
                    )
                  : Container(),
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
              decoration: InputDecoration(
                  labelText: loc!.translate("name"), icon: Icon(Icons.person)),
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return loc!.translate("field_is_empty");
                }
                if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                    .hasMatch(value)) return loc!.translate("incorrect_email");
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
                      loc!.translate("cancel"),
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
                    loc.translate("save"),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return null;
                    var res = await Api.User.edit(
                        name: _nameController.text != user?.name
                            ? _nameController.text
                            : '',
                        email: _emailController.text != user?.email
                            ? _emailController.text
                            : '');

                    if (res == null) {
                      _emailController.clear();
                      SnackBarExtension.show(SnackBarExtension.error(
                          loc!.translate('edit_email_error')));
                      return;
                    }

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
  const ConfirmationSign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)?.withBaseKey('account_screen');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Indents.md),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: Indents.sm),
              child: Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            Text(
              loc!.translate("email_confirm"),
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: Theme.of(context).textTheme.caption?.merge(TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  )),
            ),
          ],
        ),
        onTap: () {
          Api.User.confirmEmailRequest();
          Navigator.of(context, rootNavigator: true).pushNamed('/confirmation');
        },
      ),
    );
  }
}
