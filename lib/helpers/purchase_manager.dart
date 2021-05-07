import 'dart:io';

import 'package:extreme/classes/is_with_inapp_purchase_keys.dart';
import 'package:extreme/enums/payment_status.dart';
import 'package:extreme/helpers/i_app_purchase_manager.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/screens/payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';

class PurchaseManager {
  bool get iapIsUsed => false; //Platform.isIOS;

  IAPManager? iapManager;

  Future Function()? onRefresh;

  String onSuccessMessage = "Payment succeeded";
  String onErrorMessage = "Payment failure";

  Future<bool> Function(IsWithInAppPurchaseKeys?, PurchasedItem?)? onIapSuccess;
  void Function(IsWithInAppPurchaseKeys?, PurchaseResult?)? onIapError;
  void Function(PaymentStatus)? onUpdate;

  Future<String?> Function(IsWithInAppPurchaseKeys)? urlGetter;

  PurchaseManager(
      {this.iapManager,
      this.onIapSuccess,
      this.onIapError,
      this.urlGetter,
      this.onUpdate,
      this.onRefresh});

  Future init([List<String>? productKeys]) async {
    var pkLength = productKeys?.length ?? 0;

    if (iapIsUsed) {
      if (pkLength > 0) {
        iapManager ??= IAPManager(
            onError: (x, y) async {
              onIapError?.call(y, x);
              await onRefresh?.call();
              showMessage(false);
            },
            onUpdated: (x, y) async {
              var r = await onIapSuccess?.call(y, x) ?? false;
              await onRefresh?.call();
              showMessage(r);
            },
            productKeys: productKeys);
        await iapManager?.init();
      } else
        print(
            '[ ! PURCHASE MANAGER ] IAP is enabled but no product keys provided');
    }
  }

  Future purchase(IsWithInAppPurchaseKeys m, {BuildContext? context}) async =>
      ((iapIsUsed)
          ? processPaymentAsIAP(m)
          : context != null
              ? processPaymentAsKassa(context, m)
              : () {});

  Future processPaymentAsIAP(IsWithInAppPurchaseKeys m) async {
    iapManager?.requestPurchaseByModel(m);
  }

  Future processPaymentAsKassa(
      BuildContext context, IsWithInAppPurchaseKeys m) async {
    final loc = AppLocalizations.of(context)!.withBaseKey('account_screen');
    final url = await urlGetter?.call(m) ?? null;

    if (urlGetter == null)
      print(
          '[ ! PURCHASE MANAGER ] Kassa strategy is used, but not urlGetter provided');

    if (url == null) {
      SnackBarExtension.show(SnackBarExtension.error(
          AppLocalizations.of(context)!.translate('payment.error')));
      return;
    }

    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (ctx) => PaymentScreen(
              title: loc.translate('subscription_payment_app_bar'),
              url: url,
              onPaymentDone: (r) async {
                await onRefresh?.call();
                onUpdate?.call(r);
                if (r == PaymentStatus.Success)
                  showMessage();
                else if (r == PaymentStatus.Failed) showMessage(false);
              },
              onBrowserClose: () async {
                await onRefresh?.call();
              },
            )));
  }

  void showMessage([bool success = true]) {
    SnackBarExtension.show(success
        ? SnackBarExtension.success(onSuccessMessage, Duration(seconds: 5))
        : SnackBarExtension.error(onErrorMessage, Duration(seconds: 5)));
  }
}
