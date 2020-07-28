import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter_redux/flutter_redux.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    implements IWithNavigatorKey {
  Key navigatorKey;

  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

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
    var store = StoreProvider.of<AppState>(context);
    print(store.state.user);

    return ScreenBaseWidget(
        navigatorKey: navigatorKey,
        builder: (context) => <Widget>[
              Form(
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
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Logging in...' +
                                    _emailController.text +
                                    _passwordController.text)));
                            var user = await Api.Authentication.login(
                                email: _emailController.text,
                                password: _passwordController.text);
                            Scaffold.of(context).removeCurrentSnackBar();
                            if (user == null)
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Wrong password or else'),
                                backgroundColor: Colors.redAccent,
                              ));
                            else {
                              Scaffold.of(context, ).showSnackBar(SnackBar(
                                content: Text('Logged in successfully'),
                                backgroundColor: Colors.green,
                              ));
                              store.dispatch(SetUser(user));
                              Navigator.of(context, rootNavigator: true).pushNamed('/main');
                            }
                          }
                        },
                        child: Text('Log in'),
                      ),
                    ),
                  ],
                ),
              )
            ]);
  }
}
