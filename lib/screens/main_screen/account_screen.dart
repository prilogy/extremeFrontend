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
                Column(children: <Widget>[
                  BlockBaseWidget(child: AccountInfo()),
                  BlockBaseWidget(
                    header: 'Подписка',
                    child: Text(
                        'До истечения подписки: ' + 39.toString() + 'дней'),
                  ),
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
                  Padding(
                    padding: EdgeInsets.only(bottom: Indents.md),
                    child: Text(
                      'Подписка продлится с момента её текущего окончания',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  BlockBaseWidget(
                    header: 'Подключённые аккаунты',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                    ),
                  )
                ]),
              ],
            ),
          );
        });
  }
}
