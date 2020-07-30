import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthDayController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('dd.MM.yyyy');

    return ScreenBaseWidget(
        appBar: AppBar(
          title: Text('Sign up'),
        ),
        builder: (context) => <Widget>[
              BlockBaseWidget(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Введите текст самфинг';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            icon: Icon(Icons.perm_identity),
                            hintText: 'Walter White',
                            labelText: 'Name'),
                      ),
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
                            icon: Icon(Icons.lock_open), labelText: 'Password'),
                      ),
                      TextFormField(
                        controller: _rePasswordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Подтвердите проль самфинг';
                          }
                          if (value != _passwordController.text)
                            return 'Пароли не совпадают';
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Confirm password'),
                      ),
                      DateTimeField(
                          controller: _birthDayController,
                          format: format,
                          validator: (value) {
                            if(value == null) {
                              return 'Введите дату';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.date_range)
                          ),
                          onShowPicker: (context, currentValue) async {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            OutlineButton(
                              onPressed: () {},
                              child: Text('Log in'),
                            ),
                            RaisedButton(
                              onPressed: () async {
                                if(_formKey.currentState.validate()) {
                                  //TODO: call api
                                }
                              },
                              child: Text('Continue'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]);
  }
}
