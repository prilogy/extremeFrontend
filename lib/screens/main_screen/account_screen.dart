import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/account_info.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/social_account.dart';
import 'package:extreme/widgets/subsciption.dart';
import 'package:flutter/material.dart';

import '../settings_screen.dart';

class AccountScreen extends StatelessWidget implements IWithNavigatorKey {
  Key navigatorKey;
  AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => ScreenBaseWidget(
              appBar: AppBar(
                title: Text("Профиль"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings), // TODO: place correct icon
                    onPressed: () {
                      print("Settings icon pressed");
                      // TODO: implement settings call with context
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ));
                    },
                  ),
                ],
              ),
              builder: (context) => [
                BlockBaseWidget(
                  child: Column(children: <Widget>[
                    AccountInfo(),
                    Subscription(
                      color: ExtremeColors.warning,
                      price: 200,
                      title: 'месяц',
                      description: 'Идеальное решение для начала',
                    ),
                    Subscription(
                      color: ExtremeColors.success,
                      price: 1200,
                      title: 'полгода',
                      description: 'Много контента на долгое время!',
                    ),
                    Subscription(
                      color: ExtremeColors.primary,
                      price: 2000,
                      title: 'год',
                      description: 'Максимум контента прямо сейчас!',
                    ),
                    Text(
                      'Подписка продлится с момента её текущего окончания',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Подключённые аккаунты',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SocialAccount(
                          name: 'Google',
                          isConnected: false,
                        ),
                        SocialAccount(
                          name: 'VK',
                          isConnected: true,
                        ),
                        SocialAccount(
                          name: 'Facebook',
                          isConnected: false,
                        ),
                      ],
                    )
                  ]),
                )
              ],
            ),
          );
        });
  }
}
