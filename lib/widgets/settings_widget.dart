import 'package:flutter/material.dart';

// TODO: неправильный неймнг, нужно более конкретное название. Также лучше перенести этот компонент прямо в файл страницы settings_screen ибо этот виджет юзается только там
class SettingsWidget extends StatelessWidget {
  final String title;
  SettingsWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[Text(title, style: Theme.of(context).textTheme.bodyText1,)],
        ),
        Positioned.fill(
            child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print(title + ' was tapped');
            },
          ),
        ))
      ],
    );
  }
}
