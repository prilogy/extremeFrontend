import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/account_info.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/social_account.dart';
import 'package:extreme/widgets/subsciption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../settings_screen.dart';

class AccountScreen extends StatelessWidget implements IWithNavigatorKey {
  final Key navigatorKey;

  AccountScreen({Key key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var user = store.state.user;

    return ScreenBaseWidget(
      navigatorKey: navigatorKey,
      appBar: AppBar(
        title: Text("Профиль"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              print("Settings icon pressed");
              // TODO: implement settings call with context
              Navigator.of(context, rootNavigator: true).pushNamed('/settings');
            },
          ),
        ],
      ),
      builder: (context) => [
        Column(children: <Widget>[
          // TODO: в accountInfo пассить объект user который выше получин из стора
          BlockBaseWidget(child: AccountInfo(user: user)),
          BlockBaseWidget(
            header: 'Подписка',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: Indents.sm),
                  child: () {
                    var isSubscribed = user.subscription?.dateEnd != null && user.subscription.dateEnd.isAfter(DateTime.now());
                    var text = isSubscribed ? 'До истечения подписки ${user.subscription.dateEnd.difference(DateTime.now()).inDays} дня(-ей)'
                        : 'Нет активной подписки';
                    return Text(text);
                  } ()
                ),
                Subscription(
                  margin: EdgeInsets.only(bottom: Indents.smd),
                  color: ExtremeColors.warning,
                  price: 200,
                  title: 'месяц',
                  description: 'Идеальное решение для начала',
                ),
                Subscription(
                  margin: EdgeInsets.only(bottom: Indents.smd),
                  color: ExtremeColors.success,
                  price: 1200,
                  title: 'полгода',
                  description: 'Много контента на долгое время!',
                ),
                Subscription(
                  margin: EdgeInsets.only(bottom: Indents.smd),
                  color: ExtremeColors.primary,
                  price: 2000,
                  title: 'год',
                  description: 'Максимум контента прямо сейчас!',
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Подписка продлится с момента её текущего окончания',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
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
    );
  }
}
