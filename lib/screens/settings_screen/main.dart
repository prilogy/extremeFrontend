import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/store/main.dart';
import 'package:extreme/store/settings/actions.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Widget appBar = AppBar(
    title: Text("Настройки"),
  );

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var loc = AppLocalizations.of(context);

    return ScreenBaseWidget(
      appBar: appBar,
      builder: (context) => <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BlockBaseWidget(
                child: Column(
              children: [
                SettingsWidget(
                  title: 'Язык и локализация',
                  append: DropdownButton<Culture>(
                    value: store.state.settings.culture,
                    onChanged: (val) async {
                      store.dispatch(SetSettings(culture: val));
                      loc.load(Locale(val.key, ''));
                      await Api.User.refresh(true, true);
                      setState(() {});
                    },
                    items: Culture.all.map((val) {
                      return DropdownMenuItem<Culture>(
                        value: val,
                        child: new Text(val.name),
                      );
                    }).toList(),
                  ),
                ),
                SettingsWidget(title: 'Управление уведомлениями'),
                SettingsWidget(title: 'Качество видео'),
                SettingsWidget(title: 'Очистить историю просмотров'),
                SettingsWidget(title: 'Очистить историю поиска'),
              ],
            )),
            BlockBaseWidget(
                header: 'Другое',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsWidget(title: 'Политика конфидециальности'),
                    SettingsWidget(title: 'Обратная связь'),
                    SettingsWidget(title: 'Обратиться в поддержку'),
                    SettingsWidget(title: 'О приложении'),
                    SettingsWidget(
                      title: 'Выход',
                      onPressed: () {
                        store.dispatch(SetUser(null));
                        var scf = Scaffold.of(context);
                        scf.showSnackBar(SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          content: Text(
                            'Successfully logged out',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ));
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed('/auth');
                      },
                    ),
                    Text(
                      'Версия: ' + "0.6",
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
