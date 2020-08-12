import 'package:extreme/helpers/app_builder.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/main.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/router/main.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/store/main.dart';
import 'package:extreme/store/settings/actions.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var loc = AppLocalizations.of(context).withBaseKey('settings_screen');

    void _toastRestart() {
      Fluttertoast.showToast(
          msg: loc.translate('restart_hint'),
          backgroundColor: Colors.black.withOpacity(0.5));
      return null;
    }

    return ScreenBaseWidget(
      appBar: AppBar(
        title: Text(loc.translate('app_bar')),
      ),
      builder: (context) => <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BlockBaseWidget(
                child: Column(
              children: [
                SettingsWidget(
                  margin: EdgeInsets.all(0),
                  title: loc.translate('language'),
                  append: DropdownButton<Culture>(
                    value: store.state.settings.culture,
                    onChanged: (val) async {
                      store.dispatch(SetSettings(culture: val));
                      await Api.User.refresh(true, true);
                      AppLocalizations.of(context).load(Locale(val.key, ''));
                      AppBuilder.of(context).rebuild();
                      _toastRestart();
                    },
                    items: Culture.all.map((val) {
                      return DropdownMenuItem<Culture>(
                        value: val,
                        child: new Text(val.name),
                      );
                    }).toList(),
                  ),
                ),
                SettingsWidget(
                  margin: EdgeInsets.all(0),
                  title: loc.translate('currency'),
                  append: DropdownButton<Currency>(
                    value: store.state.settings.currency,
                    onChanged: (val) async {
                      store.dispatch(SetSettings(currency: val));
                      await Api.User.refresh(true, true);
                      AppBuilder.of(context).rebuild();
                      _toastRestart();
                    },
                    items: Currency.all.map((val) {
                      return DropdownMenuItem<Currency>(
                        value: val,
                        child: new Text(val.name),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )),
            BlockBaseWidget(
                header: loc.translate('other'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsWidget(title: loc.translate('policy')),
                    SettingsWidget(title: loc.translate('about')),
                    SettingsWidget(
                      title: loc.translate('exit'),
                      onPressed: () {
                        store.dispatch(SetUser(null));
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed('/auth');
                      },
                    ),
                    Text(
                      loc.translate('version', ["0.6"]),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .merge(TextStyle(color: ExtremeColors.base70[200])),
                    )
                  ],
                )),
          ],
        ),
      ],
    );
  }

}
