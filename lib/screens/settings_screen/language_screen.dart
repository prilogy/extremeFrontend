import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/router/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

/// Создаёт экран настроек приложения
class LanguageScreen extends StatelessWidget {
  LanguageScreen({Key key}) : super(key: key);
  final Widget appBar = AppBar(
    title: Text("Язык и локализация"),
  );

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    return ScreenBaseWidget(
      appBar: appBar,
      builder: (context) =>
      <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BlockBaseWidget(
                child: Column(
                  children: [
                    SettingsWidget(title: 'Язык и локализация', onPressed: () {

                    },),
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
                    SettingsWidget(title: 'Выход', onPressed: () {
                      store.dispatch(SetUser(null));
                      var scf = Scaffold.of(context);
                      scf.showSnackBar(
                          SnackBar(backgroundColor: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                            content: Text(
                              'Successfully logged out', style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onPrimary),),));
                      Navigator.of(context, rootNavigator: true).pushNamed(
                          '/auth');
                    },),
                    Text(
                      'Версия: ' + "0.6",
                      style: Theme
                          .of(context)
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
