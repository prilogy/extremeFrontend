import 'package:extreme/config/env.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/screens/payment_screen.dart';
import 'package:extreme/screens/settings_screen/about_screen.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/store/main.dart';
import 'package:extreme/store/settings/actions.dart';
import 'package:extreme/store/settings/model.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SettingsScreen extends StatelessWidget {
  final browser = MyInAppBrowser();

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var loc = AppLocalizations.of(context)?.withBaseKey('settings_screen');

    void _toastRestart() {
      Fluttertoast.showToast(
          msg: loc!.translate('restart_hint'),
          backgroundColor: Colors.black.withOpacity(0.5));
      return null;
    }

    return ScreenBaseWidget(
      appBar: AppBar(
        title: Text(loc!.translate('app_bar')),
      ),
      builder: (context) => <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StoreConnector<AppState, Settings>(
              converter: (store) => store.state.settings!,
              builder: (context, state) => BlockBaseWidget(
                  child: Column(
                children: [
                  SettingsWidget(
                    margin: EdgeInsets.all(0),
                    title: loc.translate('language'),
                    append: DropdownButton<Culture>(
                      value: store.state.settings!.culture,
                      onChanged: (val) async {
                        store.dispatch(SetSettings(culture: val));
                        await Api.User.refresh(true, true);
                        AppLocalizations.of(context)
                            ?.load(Locale(val!.key!, ''));
                        _toastRestart();
                      },
                      items: Culture.all.map((val) {
                        return DropdownMenuItem<Culture>(
                          value: val,
                          child: new Text(val.name!),
                        );
                      }).toList(),
                    ),
                  ),
                  SettingsWidget(
                    margin: EdgeInsets.all(0),
                    title: loc.translate('currency'),
                    append: DropdownButton<Currency>(
                      value: store.state.settings!.currency,
                      onChanged: (val) async {
                        store.dispatch(SetSettings(currency: val));
                        await Api.User.refresh(true, true);
                        _toastRestart();
                      },
                      items: Currency.all.map((val) {
                        return DropdownMenuItem<Currency>(
                          value: val,
                          child: new Text(val.name!),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )),
            ),
            BlockBaseWidget(
                header: loc.translate('other'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsWidget(
                      title: loc.translate('policy'),
                      onPressed: () {
                        browser.openUrlRequest(
                            urlRequest: URLRequest(
                                url: Uri.parse(
                                    config!.API_BASE_URL + '/policy.html')));
                      },
                    ),
                    SettingsWidget(
                      title: loc.translate('about'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(builder: (ctx) => AboutScreen()));
                      },
                    ),
                    SettingsWidget(
                      title: loc.translate('reset_pass'),
                      onPressed: () {
                        Api.User.resetPasswordRequest(store.state.user!.email!);
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed('/reset_pass');
                      },
                    ),
                    SettingsWidget(
                      title: loc.translate('exit'),
                      onPressed: () {
                        store.dispatch(SetUser(null));
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed('/auth');
                      },
                    ),
                    Text(
                      loc.translate('version', [config?.VERSION ?? '']),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.merge(TextStyle(color: ExtremeColors.base70[200])),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Indents.sm),
                      child: Text(
                        loc.translate('by'),
                        style: Theme.of(context).textTheme.bodyText1?.merge(
                            TextStyle(color: ExtremeColors.base70[200])),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ],
    );
  }
}
