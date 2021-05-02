import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.translate('settings_screen.about')),
      ),
      builder: (ctx) => [
        BlockBaseWidget(
            child: Text(AppLocalizations.of(context)!
                .translate('about_screen.description'))),
        BlockBaseWidget(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: Indents.sm),
                child: Text(
                    AppLocalizations.of(context)!.translate('about_screen.email')),
              ),
              SelectableText(
                'support@extremeinsiders.com',

              )
            ],
          ),
        ),
        BlockBaseWidget(
          child: Text(AppLocalizations.of(context)!.translate("about_screen.details"))
        )
      ],
    );
  }
}
