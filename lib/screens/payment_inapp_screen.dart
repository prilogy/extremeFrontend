import 'dart:io';

import 'package:extreme/classes/is_with_inapp_purchase_keys.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:collection/collection.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';

class PaymentInAppScreen extends StatefulWidget {
  final IsWithInAppPurchaseKeys keys;

  PaymentInAppScreen(this.keys);

  @override
  _PaymentInAppScreenState createState() => _PaymentInAppScreenState();
}

class _PaymentInAppScreenState extends State<PaymentInAppScreen> {
  IAPItem? _product;

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
    print(key);
    await FlutterInappPurchase.instance.initConnection;
    var products = await FlutterInappPurchase.instance.getProducts([key!]);
    print(products.toString());
    _product = products.firstWhereOrNull((x) => x.productId == key);
    if (_product != null) purchase(_product!);
  }

  @override
  void dispose() async {
    super.dispose();
    await FlutterInappPurchase.instance.endConnection;
  }

  void purchase(IAPItem item) {
    print(item.toString());
    FlutterInappPurchase.instance.requestPurchase(item.productId!);
  }

  @override
  Widget build(BuildContext context) {
    // if (key == null || _product == null)
    //   SchedulerBinding.instance?.addPostFrameCallback((_) {
    //     SnackBarExtension.show(SnackBarExtension.error(
    //         AppLocalizations.of(context)!.translate('payment.error')));
    //     Navigator.of(context).pop();
    //   });
    //
    //
    final loc = AppLocalizations.of(context)?.withBaseKey('payment');

    return ScreenBaseWidget(
      appBar: AppBar(),
      builderChild: (context) => BlockBaseWidget(
        padding: EdgeInsets.symmetric(vertical: Indents.xl),
        child: Column(
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            ),
            Container(
              margin: EdgeInsets.only(top: Indents.xl),
              child: Text(loc!.translate('processing')),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
