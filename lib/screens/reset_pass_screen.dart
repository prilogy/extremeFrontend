import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/intents.dart';
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
  var email;
  @override
  Widget build(BuildContext context) {
    var user = StoreProvider.of<AppState>(context).state.user;
    if (email == null) {
      email = user?.email ?? null;
    }
    final loc = AppLocalizations.of(context).withBaseKey('reset_pass_screen');
    var theme = Theme.of(context);
    final _formKey = GlobalKey<FormState>();

    TextEditingController _controller = TextEditingController();
    if (email == null) {
      return ScreenBaseWidget(
          appBar: AppBar(title: Text(loc.translate('title'))),
          builder: (context) => [
                BlockBaseWidget(
                  child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Text(loc.translate('instruction.email')),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: Indents.md),
                        child: TextFormField(
                          controller: _controller,
                          decoration:
                              InputDecoration(hintText: 'example@gmail.com'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return loc.translate('error.empty');
                            } else if (!RegExp(
                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(value))
                              return loc.translate('error.invalid');
                            return null;
                          },
                        ),
                      ),
                      RaisedButton(
                        child: Text(loc.translate('next')),
                        onPressed: () => setState(() {
                          if (_formKey.currentState.validate()) {
                            email = _controller.text;
                          }
                        }),
                      )
                    ]),
                  ),
                )
              ]);
    } else if (!isVerified) {
      return ScreenBaseWidget(
        appBar: AppBar(
          title: Text(loc.translate('title')),
        ),
        builder: (context) => [
          Form(
            key: _formKey,
            child: BlockBaseWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset('assets/svg/email.svg'),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Indents.md),
                    child: Center(
                        child: Text(
                      loc.translate('instruction.reset', [email]),
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    )),
                  ),
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
                      validator: (value) {
                        if (int.tryParse(value) == null && value.length > 0) {
                          return loc.translate('validation.NaN');
                        }
                        return null;
                      },
                      onChanged: null,
                      onCompleted: (text) async {
                        if (_formKey.currentState.validate()) {
                          var response = await Api.User.verify(text);
                          if (response == true) {
                            setState(() {
                              isVerified = true;
                              code = text;
                            });
                          } else {
                            Scaffold.of(context).showSnackBar(
                                SnackBarExtension.error(
                                    loc.translate('snackbar.error')));
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
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
          title: Text(loc.translate('title')),
        ),
        builder: (context) => [
          BlockBaseWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: loc.translate('new_pass')),
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
                TextFormField(
                  controller: _verifyController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: loc.translate('conf_new_pass')),
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
                RaisedButton(
                    child: Text(loc.translate('change_pass')),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var response = await Api.User.resetPasswordAttempt(
                            code, _passController.text);
                        Scaffold.of(context).showSnackBar(response
                            ? SnackBarExtension.success(
                                loc.translate('snackbar.success'))
                            : SnackBarExtension.error(
                                loc.translate('snackbar.error')));
                        Navigator.popUntil(
                            context, ((route) => !route.navigator.canPop()));
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
