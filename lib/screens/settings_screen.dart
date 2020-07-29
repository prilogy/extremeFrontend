import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/settings_widget.dart';
import 'package:flutter/material.dart';

/// Создаёт экран настроек приложения
class SettingsScreen extends StatelessWidget  {
  SettingsScreen({Key key}) : super(key: key);
  final Widget appBar = AppBar(
    title: Text("Настройки"),
  );
  @override
  Widget build(BuildContext context) {
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
                SettingsWidget(title: 'Язык и локализация'),
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
                    Text(
                      'Версия: ' + "3.1.1.17",
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
