import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/settings_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget implements IWithAppBar {
  @override
  final Widget appBar = AppBar(
    title: Text("Настройки"),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Indents.md),
      child: ListView(
        children: <Widget>[
          SettingsWidget(title: 'Язык и локализация'),
          SettingsWidget(title: 'Управление уведомлениями'),
          SettingsWidget(title: 'Качество видео'),
          SettingsWidget(title: 'Очистить историю просмотров'),
          SettingsWidget(title: 'Очистить историю поиска'),
          Text(
            'Другое',
            style: Theme.of(context).textTheme.headline6,
          ),
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
      ),
    );
  }
}
