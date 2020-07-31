import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:extreme/services/api/main.dart' as Api;

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
  final _phoneNumberController = TextEditingController();
  final _birthDayController = TextEditingController();
  final _imageController = TextEditingController();
  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      _imageController.text = _image.path.split('/').last;
    });
  }

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
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.phone_android),
                            labelText: 'Phone number'),
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
                            if (value == null) {
                              return 'Введите дату';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              icon: Icon(Icons.date_range),
                              labelText: 'Birthday date'),
                          onShowPicker: (context, currentValue) async {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          }),
                      TextFormField(
                        controller: _imageController,
                        focusNode: AlwaysDisabledFocusNode(),
                        decoration: const InputDecoration(
                            icon: Icon(Icons.photo), labelText: 'Avatar'),
                        onTap: () {
                          getImage();
                        },
                      ),
                      if (_image != null)
                        Container(
                            margin: EdgeInsets.only(top: Indents.sm),
                            height: 100,
                            decoration: new BoxDecoration(
                                image: new DecorationImage(
                              image: FileImage(_image),
                              fit: BoxFit.contain,
                            ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            OutlineButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/auth');
                              },
                              child: Text('Log in'),
                            ),
                            RaisedButton(
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () async {
                                var scf = Scaffold.of(context);
                                if (_formKey.currentState.validate()) {
                                  var result = await Api.Authentication.signUp(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      avatar: _image,
                                      dateBirthday: _birthDayController.text,
                                      name: _nameController.text,
                                      phoneNumber: _phoneNumberController.text);
                                  if (result == true) {
                                    scf.showSnackBar(SnackBar(
                                      content: Text('Регистрация успешна'),
                                    ));
                                    Navigator.of(context).pop();
                                  } else {
                                    scf.showSnackBar(SnackBar(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                      content:
                                          Text('Email уже зарегистрирован'),
                                    ));
                                  }
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
