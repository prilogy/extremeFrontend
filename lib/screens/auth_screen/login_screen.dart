import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/router/main.dart';
import 'package:extreme/screens/auth_screen/signup_screen.dart';
import 'package:extreme/services/localstorage.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter_redux/flutter_redux.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    print('from local storage: ' + localStorage.getItem('user').toString());
    var colorScheme = Theme.of(context).colorScheme;

    return ScreenBaseWidget(
        builderChild: (context) =>
            Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              BlockBaseWidget(
                header: 'Log in',
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
                            return 'Неправильный формат email';
                          return null;
                        },
                        decoration: const InputDecoration(
                            icon: Icon(Icons.alternate_email),
                            hintText: 'example@gmail.com',
                            labelText: 'Email'),
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
                        decoration: const InputDecoration(
                            icon: Icon(Icons.lock), labelText: 'Password'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            OutlineButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                              },
                              child: Text('Sign up'),
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
                              child: Text('Log in'),
                            ),
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
