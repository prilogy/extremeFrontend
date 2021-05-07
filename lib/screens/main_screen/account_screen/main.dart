import 'dart:io';

import 'package:extreme/containers/subscription_plans_container.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/screens/main_screen/account_screen/favorite_screen.dart';
import 'package:extreme/screens/main_screen/account_screen/promo_screen.dart';
import 'package:extreme/screens/main_screen/account_screen/sale_screen.dart';
import 'package:extreme/services/social_auth.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/account_info.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/social_account.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AccountScreen extends StatelessWidget implements IWithNavigatorKey {
  final Key? navigatorKey;

  AccountScreen({Key? key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)?.withBaseKey('account_screen');
    var store = StoreProvider.of<AppState>(context);
    var user = store.state.user;
    var platform = Platform.isIOS ? SocialAuthOS.IOS : SocialAuthOS.Android;

    return ScreenBaseWidget(
      onRefresh: () async {
        await Api.User.refresh(true, true);
      },
      navigatorKey: navigatorKey,
      appBar: AppBar(
        title: Text(loc!.translate("app_bar")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.local_activity),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PromoScreen()));
            },
          ),
          if (user!.isSubscribed)
            IconButton(
              icon: Icon(Icons.attach_money),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SaleScreen()));
              },
            ),
          if (user.isSubscribed)
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FavoriteScreen()));
              },
            ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/settings');
            },
          ),
        ],
      ),
      builder: (context) => [
        Column(children: <Widget>[
          BlockBaseWidget(child: AccountInfo()),
          BlockBaseWidget(
            header: loc.translate("subscription"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StoreConnector<AppState, Models.User>(
                  converter: (store) => store.state.user!,
                  builder: (ctx, state) => Container(
                      margin: EdgeInsets.only(bottom: Indents.smd),
                      child: () {
                        var isSubscribed = user.isSubscribed;
                        var text = isSubscribed
                            ? loc.translate("expiration", [
                                state.subscription!.dateEnd
                                        ?.difference(DateTime.now())
                                        .inDays
                                        .toString() ??
                                    ''
                              ])
                            : loc.translate("no_sub");
                        return Text(text);
                      }()),
                ),
                SubscriptionPlansContainer(),
                Container(
                  width: double.infinity,
                  child: Text(
                    loc.translate("hint"),
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SocialAuthService.all.any((x) => !x.hideFor.contains(platform))
              ? BlockBaseWidget(
                  margin: EdgeInsets.all(0),
                  header: loc.translate("connected_accounts"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var item in SocialAuthService.all)
                        SocialAccount(
                          service: item,
                        )
                    ],
                  ),
                )
              : Container()
        ]),
      ],
    );
  }
}
