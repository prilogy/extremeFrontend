import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/screens/payment_screen.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/account_info.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/social_account.dart';
import 'package:extreme/widgets/subsciption.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:extreme/services/api/main.dart' as Api;

class AccountScreen extends StatelessWidget implements IWithNavigatorKey {
  final Key navigatorKey;

  AccountScreen({Key key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('account_screen');
    var store = StoreProvider.of<AppState>(context);
    var user = store.state.user;

    return ScreenBaseWidget(
      navigatorKey: navigatorKey,
      appBar: AppBar(
        title: Text(loc.translate("app_bar")),
        actions: <Widget>[
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
                Container(
                    margin: EdgeInsets.only(bottom: Indents.smd),
                    child: () {
                      var isSubscribed = user.subscription?.dateEnd != null &&
                          user.subscription.dateEnd.isAfter(DateTime.now());
                      var text = isSubscribed
                          ? loc.translate("expiration", [user.subscription.dateEnd.difference(DateTime.now()).inDays.toString()])
                          : loc.translate("no_sub");
                      return Text(text);
                    }()),
                CustomFutureBuilder<List<Models.SubscriptionPlan>>(
                  future: Api.Subscription.getPlans(),
                  builder: (data) {
                    return CustomListBuilder(
                        lastItemHasGap: true,
                        items: data,
                        itemBuilder: (item) => Subscription(
                              model: item,
                              /* onPressed: () async {
                                  var url =
                                      await Api.Subscription.getPaymentUrl(
                                          item?.id ?? 1);
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                          builder: (ctx) => PaymentScreen(
                                                title: 'Оплата подписки',
                                                url: url,
                                              )));
                                }, */
                            ));
                  },
                ),
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

          BlockBaseWidget(
            header: loc.translate("connected_accounts"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for(var item in Models.SocialAccountProvider.all)
                  SocialAccount(
                    model: item,
                  )
              ],
            ),
          )
        ]),
      ],
    );
  }
}
