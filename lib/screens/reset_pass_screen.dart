import 'dart:convert';

import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:extreme/services/api/main.dart' as Api;

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({Key key}) : super(key: key);

  @override
  _ResetPassScreenState createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  bool isVerified = false;
  String code;
  @override
  Widget build(BuildContext context) {
    var user = StoreProvider.of<AppState>(context).state.user;
    var email = user.email;
    final loc = AppLocalizations.of(context).withBaseKey('reset_pass_screen');
    var theme = Theme.of(context);
    TextEditingController _controller = TextEditingController();
    if (!isVerified) {
      return ScreenBaseWidget(
        appBar: AppBar(
          title: Text(loc.translate('title')),
        ),
        builder: (context) => [
          BlockBaseWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('assets/svg/email.svg'),
                Center(
                    child: Text(
                  loc.translate('instruction', [email]),
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                )),
                Container(
                  width: 285,
                  child: PinCodeTextField(
                    length: 5,
                    autoValidate: true,
                    textInputType: TextInputType.number,
                    backgroundColor: theme.colorScheme.background,
                    textStyle: theme.textTheme.headline3.merge(
                        TextStyle(color: theme.colorScheme.onBackground)),
                    controller: _controller,
                    pinTheme: PinTheme(
                      fieldWidth: 45,
                      fieldHeight: 62,
                      activeColor: theme.colorScheme.onBackground,
                    ),
                    onChanged: (text) {
                      print(int.tryParse(text));
                    },
                    onCompleted: (text) async {
                      if (int.tryParse(text) != null) {
                        var response = await Api.User.verify(text);
                        if (response == true) {
                          print('its okay');
                          setState(() {
                            isVerified = true;
                            code = text;
                          });
                        } else {
                          print('oshibka');
                        }
                      } else {
                        print('poshel ti! $text is not a number');
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return SetNewPassword(user: user, code: code);
    }
  }
}

class SetNewPassword extends StatelessWidget {
  final User user;
  final String code;
  const SetNewPassword({Key key, this.user, this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _passController = TextEditingController();
    TextEditingController _verifyController = TextEditingController();
    final loc = AppLocalizations.of(context).withBaseKey('reset_pass_screen');
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: ScreenBaseWidget(
        appBar: AppBar(
          title: Text(loc.translate('title')), //TODO: localization
        ),
        builder: (context) => [
          BlockBaseWidget(
            header: loc.translate('new_pass'),
            child: TextFormField(
              controller: _passController,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return loc.translate("error.empty");
                } else if (value != _verifyController.text) {
                  return loc.translate("error.dont_match");
                } else if (value.length < 6) {
                  return loc.translate("error.few_symbols");
                } else
                  return null;
              },
            ),
          ),
          BlockBaseWidget(
            header: loc.translate('conf_new_pass'),
            child: TextFormField(
              controller: _verifyController,
              obscureText: true,
              validator: (value) {
                if (_passController.text.length >= 6) {
                  if (value.isEmpty) {
                  return loc.translate("error.empty");
                } else if (value != _passController.text) {
                  return loc.translate("error.dont_match");
                } else if (value.length < 6) {
                  return loc.translate("error.few_symbols");
                } else
                  return null;
                }
                return null;
              },
              onEditingComplete: () {
                _formKey.currentState.validate();
              },
            ),
          ),
          BlockBaseWidget(
            crossAxisAlignment: CrossAxisAlignment.center,
            child: RaisedButton(
                child: Text(loc.translate('confirmation')),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await Api.User.resetPasswordAttempt(
                        code, _passController.text);
                  }
                }),
          )
        ],
      ),
    );
  }
}
