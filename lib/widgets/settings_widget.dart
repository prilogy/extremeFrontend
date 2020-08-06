import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

// TODO: неправильный неймнг, нужно более конкретное название. Также лучше перенести этот компонент прямо в файл страницы settings_screen ибо этот виджет юзается только там
class SettingsWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget append;

  SettingsWidget({this.title, this.onPressed, this.append});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Indents.md, bottom: Indents.md),
      child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: onPressed ?? () {},
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                      color: ExtremeColors.base[100],
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
                ),
              ),
              append ?? Container()
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
    );
  }
}
