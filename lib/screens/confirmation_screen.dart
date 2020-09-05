import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Confirmation extends StatelessWidget {
  Confirmation({Key key}) : super(key: key);
  bool pending = true;

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    final loc = AppLocalizations.of(context).withBaseKey('confirmation_screen');
    var theme = Theme.of(context);
    final _formKey = GlobalKey<FormState>();
    TextEditingController _controller = TextEditingController();
    return Form(
      key: _formKey,
      child: ScreenBaseWidget(
        appBar: AppBar(title: Text(loc.translate('title'))),
        builder: (context) => [
          BlockBaseWidget(
            child: Column(
              children: <Widget>[
                SvgPicture.asset('assets/svg/email.svg'),
                Text(
                  loc.translate('instruction', [store.state.user.email]),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                PinCodeTextField(
                  length: 5,
                  autoValidate: true,
                  textInputType: TextInputType.number,
                  backgroundColor: theme.colorScheme.background,
                  textStyle: theme.textTheme.headline3
                      .merge(TextStyle(color: theme.colorScheme.onBackground)),
                  controller: _controller,
                  pinTheme: PinTheme(
                    fieldWidth: 45,
                    fieldHeight: 62,
                    activeColor: theme.colorScheme.onBackground,
                  ),
                  validator: (value) {
                    if (int.tryParse(value) == null) {
                      return loc.translate('validation.NaN');
                    }
                    return null;
                  },
                  onChanged: (text) {},
                  onCompleted: (text) async {
                    if (_formKey.currentState.validate()) {
                      var response =
                          await Api.User.confirmEmailAttempt(_controller.text);
                      if (response == true) {
                        Navigator.popUntil(
                            context, ((route) => !route.navigator.canPop()));
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBarExtension.error(
                                loc.translate('snackbaar.wrong_code')));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
