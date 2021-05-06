import 'dart:io';

import 'package:extreme/helpers/i_app_purchase_manager.dart';
import 'package:extreme/helpers/purchase_manager.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/apple_payment.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/screens/payment_screen.dart';
import 'package:extreme/services/api/main.dart';
import 'package:collection/collection.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/subsciption_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/classes/is_with_inapp_purchase_keys.dart';

class SubscriptionPlansContainer extends StatefulWidget {
  @override
  _SubscriptionPlansContainerState createState() =>
      _SubscriptionPlansContainerState();
}

class _SubscriptionPlansContainerState
    extends State<SubscriptionPlansContainer> {
  bool _isLoaded = false;
  List<SubscriptionPlan>? _plans;

  final PurchaseManager _purchaseManager = PurchaseManager(
    urlGetter: (item) => Subscription.getPaymentUrl(item.id!)
  );

  //     IAppPurchaseManager(onError: (res, m) {
  //   print("IAP Error");
  // }, onUpdated: (item, m) async {
  //   print(m.toString());
  //   var r = await AppleNotification.payment(ApplePayment(
  //       entityId: m?.id, transactionReceipt: item?.transactionReceipt));
  //   print(r);
  // });

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  void asyncInitState() async {
    _plans = (await Subscription.getPlans())
        ?.sorted((a, b) => a.id?.compareTo(b.id ?? 0) ?? -1)
        .toList();

    await _purchaseManager.init(productKeys: _plans?.productKeys);

    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoaded
        ? CircularProgressIndicator()
        : CustomListBuilder<SubscriptionPlan>(
            lastItemHasGap: true,
            items: _plans,
            itemBuilder: (item) => SubscriptionCard(
                  iapItem:
                      _purchaseManager.iapManager?.productById(item.productId),
                  model: item,
                  onPressed: () async {
                    await _purchaseManager.purchase(item, context: context);
                  },
                ));
  }
}
