import 'dart:io';

import 'package:extreme/classes/is_with_inapp_purchase_keys.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class PaymentInAppScreen extends StatefulWidget {
  final IsWithInAppPurchaseKeys keys;

  PaymentInAppScreen(this.keys);

  @override
  _PaymentInAppScreenState createState() => _PaymentInAppScreenState();
}

class _PaymentInAppScreenState extends State<PaymentInAppScreen> {
  List<IAPItem> _products = [];

  String? get key => Platform.isIOS
      ? widget.keys.appleInAppPurchaseKey
      : widget.keys.googleInAppPurchaseKey;

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  void asyncInitState() async {
    if (key == null) return;
    await FlutterInappPurchase.instance.initConnection;
    _products = await FlutterInappPurchase.instance.getProducts([key!]);
  }

  @override
  void dispose() async {
    await FlutterInappPurchase.instance.endConnection;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (key == null)
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        SnackBarExtension.show(SnackBarExtension.error(
            AppLocalizations.of(context)!.translate('payment.error')));
        Navigator.of(context).pop();
      });

    return Container();
  }
}
