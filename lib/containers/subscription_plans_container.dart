import 'dart:io';

import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/screens/payment_inapp_screen.dart';
import 'package:extreme/screens/payment_screen.dart';
import 'package:extreme/services/api/main.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/subsciption_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;

class SubscriptionPlansContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<List<SubscriptionPlan>?>(
      future: Subscription.getPlans(),
      builder: (data) {
        data?.sort((a, b) => a.price!.value!.compareTo(b.price!.value!));
        return CustomListBuilder(
            lastItemHasGap: true,
            items: data,
            itemBuilder: (item) => SubscriptionCard(
                  model: item as SubscriptionPlan,
                  onPressed: () async {
                    await processPayment(context, item);
                  },
                ));
      },
    );
  }
}

Future processPayment(BuildContext context, SubscriptionPlan item) async {
  if(Platform.isIOS) await processPaymentIOS(context, item);
  else await processPaymentKassa(context, item);
}

Future processPaymentIOS(BuildContext context, SubscriptionPlan item) async {
  Navigator.of(context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (ctx) => PaymentInAppScreen(item)));
}

Future processPaymentKassa(BuildContext context, SubscriptionPlan item) async {
  final loc = AppLocalizations.of(context)!.withBaseKey('account_screen');
  var url = await Subscription.getPaymentUrl(item.id!);

  if (url == null) {
    SnackBarExtension.show(SnackBarExtension.error(
        AppLocalizations.of(context)!.translate('payment.error')));
    return;
  }

  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (ctx) => PaymentScreen(
            title: loc.translate('subscription_payment_app_bar'),
            url: url,
            onPaymentDone: () async {
              await Api.User.refresh(true, true);
              SnackBarExtension.show(SnackBarExtension.success(
                  loc.translate('subscription_payment_success'),
                  Duration(seconds: 7)));
            },
            onBrowserClose: () async {
              await Api.User.refresh(true, true);
            },
          )));
}
