import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

// TODO: неправильный неймнг, нужно более конкретное название. Также лучше перенести этот компонент прямо в файл страницы settings_screen ибо этот виджет юзается только там
class SettingsWidget extends StatelessWidget {
  final String title;
  SettingsWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Indents.md, bottom: Indents.md),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[Text(title, style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: ExtremeColors.base[100], letterSpacing: 0.5, fontSize: 18, fontWeight: FontWeight.w400)),)],
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
      ),
    );
  }
}
