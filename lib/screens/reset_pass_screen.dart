import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:extreme/services/api/main.dart' as Api;

class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVerified = false;
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
                Icon(
                  Icons.email,
                  size: 100,
                ),
                Center(
                    child: Text(
                  'Для того, чтобы сбросить пароль, введите код, который был отправлен Вам на почту',
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
                          print('ok');
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
      return ScreenBaseWidget(
        appBar: AppBar(title: Text('password rest')),
        builder: (context) => [Text('he')],
      );
    }
  }
}
