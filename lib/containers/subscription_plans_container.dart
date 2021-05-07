import 'package:extreme/helpers/purchase_manager.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/apple_payment.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/services/api/main.dart';
import 'package:collection/collection.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/subsciption_card.dart';
import 'package:flutter/material.dart';
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

  final PurchaseManager _pManager = PurchaseManager(
      urlGetter: (item) => Subscription.getPaymentUrl(item.id!),
      onRefresh: () => Api.User.refresh(true, true),
      onIapSuccess: (model, iap) => AppleNotification.payment(ApplePayment(
          planId: model?.id, transactionReceipt: iap?.transactionReceipt)));

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  void asyncInitState() async {
    _plans = (await Subscription.getPlans())
        ?.sorted((a, b) => a.id?.compareTo(b.id ?? 0) ?? -1)
        .toList();

    await _pManager.init(_plans?.productKeys);

    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!.translate;
    _pManager.onSuccessMessage =
        loc('account_screen.subscription_payment_success');
    _pManager.onErrorMessage = loc('payment.error');

    return !_isLoaded
        ? CircularProgressIndicator()
        : CustomListBuilder<SubscriptionPlan>(
            lastItemHasGap: true,
            items: _plans,
            itemBuilder: (item) => SubscriptionCard(
                  iapItem: _pManager.iapManager?.productById(item.productId),
                  model: item,
                  onPressed: () async {
                    await _pManager.purchase(item, context: context);
                  },
                ));
  }
}
