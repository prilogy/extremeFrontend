import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

// TODO: неправильный неймнг, нужно более конкретное название. Также лучше перенести этот компонент прямо в файл страницы settings_screen ибо этот виджет юзается только там
class SettingsWidget extends StatelessWidget with IndentsMixin {
  final String? title;
  final VoidCallback? onPressed;
  final Widget? append;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  SettingsWidget(
      {this.title,
      this.onPressed,
      this.append,
      this.margin = const EdgeInsets.only(bottom: Indents.md),
      this.padding});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: padding,
      margin: margin,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: onPressed ?? () {},
            child: Text(
              title ?? '',
              style: Theme.of(context).textTheme.bodyText2?.merge(TextStyle(
                  color: theme.colorScheme.onBackground,
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
