import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/screens/auth_screen/signup_screen.dart';
import 'package:extreme/screens/reset_pass_screen.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter_redux/flutter_redux.dart';

class LoginEmailScreen extends StatefulWidget {
  @override
  _LoginEmailScreenState createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  //Key navigatorKey;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context).withBaseKey('login_email_screen');
    return ScreenBaseWidget(
        appBar: AppBar(
          title: Text('Вход с Email'),
        ),
        builderChild: (context) =>
            Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              BlockBaseWidget(
                header: loc.translate('header'),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Введите текст самфинг';
                          }
                          if (!RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(value))
                            return 'Неправильный формат email'; // TODO: add lozaliztion
                          return null;
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.alternate_email),
                            hintText: 'example@gmail.com',
                            labelText: loc.translate('email')),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Введите проль самфинг';
                          }
                          if (value.length < 6) return 'э длина >= 6';
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: loc.translate('password')),
                      ),
                      InkWell(
                        child: Text(loc.translate('forget')),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ResetPassScreen()));
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            OutlineButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                              },
                              child: Text(loc.translate('sign_up')),
                            ),
                            RaisedButton(
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () async {
                                var scf = Scaffold.of(context);
                                if (_formKey.currentState.validate()) {
                                  scf.showSnackBar(SnackBar(
                                      backgroundColor: colorScheme.primary,
                                      content: Text(
                                        'Logging in...' +
                                            _emailController.text +
                                            _passwordController.text,
                                        style: TextStyle(
                                            color: colorScheme.onPrimary),
                                      )));
                                  var user = await Api.Authentication.login(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                  scf.removeCurrentSnackBar();
                                  if (user == null)
                                    scf.showSnackBar(SnackBar(
                                      content: Text(
                                        'Wrong password or else',
                                        style: TextStyle(
                                            color: colorScheme.onError),
                                      ),
                                      backgroundColor: colorScheme.error,
                                    ));
                                  else {
                                    scf.showSnackBar(SnackBar(
                                      content: Text(
                                        'Logged in successfully',
                                        style: TextStyle(
                                            color: colorScheme.onError),
                                      ),
                                      backgroundColor: ExtremeColors.success,
                                    ));
                                    store.dispatch(SetUser(user));
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed('/main');
                                  }
                                }
                              },
                              child: Text(
                                loc.translate('sign_in'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]));
  }
}
