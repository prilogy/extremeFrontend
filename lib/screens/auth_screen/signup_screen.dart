import 'dart:io';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:extreme/services/api/main.dart' as Api;

class SignUpScreen extends StatefulWidget {
  final String? token;
  final SocialAccountProvider? accountProvider;

  SignUpScreen({this.token, this.accountProvider});

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
  File? _image;

  SocialIdentity? socialIdentity;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageController.text = _image!.path.split('/').last;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.accountProvider != null) {
      Api.Authentication.signUpSocialGetInfo(
              widget.accountProvider!, widget.token!)
          .then((value) {
        socialIdentity = value;
        _nameController.text = socialIdentity?.name ?? '';
        _emailController.text = socialIdentity?.email ?? '';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _birthDayController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)?.withBaseKey('sign_up_screen');

    var providerName = widget.accountProvider?.name ?? null;
    providerName != null
        ? providerName =
            providerName[0].toUpperCase() + providerName.substring(1)
        : providerName = null;
    var title = widget.token == null
        ? loc!.translate('title')
        : loc!.translate('title_with', [providerName!]);
    var format = DateFormat('dd.MM.yyyy');

    return ScreenBaseWidget(
        appBar: AppBar(
          title: Text(title),
        ),
        builder: (context) => <Widget>[
              BlockBaseWidget(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // TextFormField(
                      //   controller: _nameController,
                      //   validator: (value) {
                      //     if (value.isEmpty) {
                      //       return loc!.translate('error.empty');
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //       icon: Icon(Icons.perm_identity),
                      //       hintText: 'Walter White',
                      //       labelText: loc!.translate('name')),
                      // ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Введите текст самфинг';
                          }
                          if (!RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(value!))
                            return 'Неправильный формат email';
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
                          if (value!.isEmpty) {
                            return loc.translate('error.empty');
                          }
                          if (value.length < 6)
                            return loc.translate('error.few_symbols');
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock_open),
                            labelText: loc.translate('password')),
                      ),
                      TextFormField(
                        controller: _rePasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return loc.translate('error.empty');
                          }
                          if (value != _passwordController.text)
                            return loc.translate('error.dont_match');
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: loc.translate('repeat_password')),
                      ),
                      // TextFormField(
                      //   controller: _phoneNumberController,
                      //   decoration: InputDecoration(
                      //       icon: Icon(Icons.phone_android),
                      //       labelText: loc!.translate('phone_number')),
                      // ),
                      // DateTimeField(
                      //     controller: _birthDayController,
                      //     format: format,
                      //     validator: (value) {
                      //       if (value == null) {
                      //         return loc!.translate('error.empty_date');
                      //       }
                      //       return null;
                      //     },
                      //     decoration: InputDecoration(
                      //         icon: Icon(Icons.date_range),
                      //         labelText: loc!.translate('date_of_birth')),
                      //     onShowPicker: (context, currentValue) async {
                      //       return showDatePicker(
                      //           context: context,
                      //           firstDate: DateTime(1900),
                      //           initialDate: currentValue ?? DateTime.now(),
                      //           lastDate: DateTime(2100));
                      //     }),
                      // TextFormField(
                      //   controller: _imageController,
                      //   focusNode: AlwaysDisabledFocusNode(),
                      //   decoration: InputDecoration(
                      //       icon: Icon(Icons.photo),
                      //       labelText: loc!.translate('avatar')),
                      //   onTap: () {
                      //     getImage();
                      //   },
                      // ),
                      if (_image != null)
                        Container(
                            margin: EdgeInsets.only(top: Indents.sm),
                            height: 100,
                            decoration: new BoxDecoration(
                                image: new DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.contain,
                            ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: Indents.md),
                              child: OutlineButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/auth');
                                },
                                child: Text(loc.translate('sign_in')),
                              ),
                            ),
                            RaisedButton(
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () async {
                                var scf = Scaffold.of(context);
                                if (_formKey.currentState!.validate()) {
                                  var result = await Api.Authentication.signUp(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      name: null,
                                      dateBirthday: null,
                                      // avatar: _image,
                                      // dateBirthday: _birthDayController.text,
                                      // name: _nameController.text,
                                      // phoneNumber: _phoneNumberController.text,
                                      // socialIdentity: socialIdentity ?? null,
                                      // socialProvider:
                                      //     widget.accountProvider ?? null
                                  );
                                  if (result == true) {
                                    scf.showSnackBar(SnackBar(
                                      content: Text(loc.translate('success')),
                                    ));
                                    Navigator.of(context).pop();
                                  } else {
                                    scf.showSnackBar(SnackBar(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                      content:
                                          Text(loc.translate('error.already_exists')),
                                    ));
                                  }
                                }
                              },
                              child: Text(loc.translate('continue'))
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
