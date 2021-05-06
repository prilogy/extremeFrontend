import 'dart:io';

import 'package:extreme/classes/is_with_inapp_purchase_keys.dart';
import 'package:extreme/helpers/i_app_purchase_manager.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/screens/payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';

class PurchaseManager {
  bool get iapIsUsed => Platform.isIOS;

  IAPManager? iapManager;

  Future Function()? onRefresh;

  void Function(IsWithInAppPurchaseKeys?, PurchasedItem?)? onIapSuccess;
  void Function(IsWithInAppPurchaseKeys?, PurchaseResult?)? onIapError;

  Future<String?> Function(IsWithInAppPurchaseKeys)? urlGetter;

  PurchaseManager({this.iapManager, this.onIapSuccess, this.onIapError, this.urlGetter});

  Future init({List<String>? productKeys}) async {
    if (iapIsUsed) {
      iapManager ??= IAPManager(
          onError: (x, y) async {
            onIapError?.call(y, x);
            await onRefresh?.call();
          },
          onUpdated: (x, y) async {
            onIapSuccess?.call(y, x);
            await onRefresh?.call();
          },
          productKeys: productKeys);
      await iapManager?.init();
    }
  }

  Future purchase(IsWithInAppPurchaseKeys m, {BuildContext? context}) async => ((iapIsUsed)
        ? processPaymentAsIAP(m)
        : context != null ? processPaymentAsKassa(context, m): () {});

  Future processPaymentAsIAP(IsWithInAppPurchaseKeys m) async {
    iapManager?.requestPurchaseByModel(m);
  }

  Future processPaymentAsKassa(
      BuildContext context, IsWithInAppPurchaseKeys m) async {
    final loc = AppLocalizations.of(context)!.withBaseKey('account_screen');
    final url = await urlGetter?.call(m) ?? null;

    if(urlGetter == null) print('[ ! PURCHASE MANAGER ] Kassa strategy is used, but not urlGetter provided');

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
                await onRefresh?.call();
                SnackBarExtension.show(SnackBarExtension.success(
                    loc.translate('subscription_payment_success'),
                    Duration(seconds: 7)));
                // TODO: implement status checker
              },
              onBrowserClose: () async {
                await onRefresh?.call();
              },
            )));
  }
}
