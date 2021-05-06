import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:extreme/classes/is_with_inapp_purchase_keys.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_inapp_purchase/modules.dart';

class IAppPurchaseManager {
  IsWithInAppPurchaseKeys? _purchaseModel;

  bool get isAvailable => Platform.isIOS;

  List<IAPItem>? products;
  StreamSubscription<PurchasedItem?>? _purchaseUpdatedSubscription;
  StreamSubscription<PurchaseResult?>? _purchaseErrorSubscription;

  List<String>? productKeys;
  void Function(PurchasedItem?, IsWithInAppPurchaseKeys?)? onUpdated;
  void Function(PurchaseResult?, IsWithInAppPurchaseKeys?)? onError;

  IAppPurchaseManager({this.productKeys, this.onError, this.onUpdated});

  Future init(List<String> productKeys) async {
    if (!isAvailable) {
      print("[ In app purchases disabled on current platform ]");
      return;
    }
    await FlutterInappPurchase.instance.initConnection;
    _setupListeners();
    print(await FlutterInappPurchase.instance.clearTransactionIOS() ?? "");
    products = await FlutterInappPurchase.instance.getProducts(productKeys);
  }

  void _setupListeners() {
    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((x) {
      onUpdated?.call(x, _purchaseModel);
      _purchaseModel = null;
    });
    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((x) {
      onError?.call(x, _purchaseModel);
      _purchaseModel = null;
    });
  }

  bool requestPurchase(IAPItem item) {
    try {
      FlutterInappPurchase.instance.requestPurchase(item.productId!);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool requestPurchaseByKey(String key) {
    var item = products?.firstWhereOrNull((x) => x.productId == key);
    if (item == null) return false;
    return requestPurchase(item);
  }

  bool requestPurchaseByModel(IsWithInAppPurchaseKeys item) {
    var key = item.productId;
    if (key == null) return false;
    _purchaseModel = item;
    return requestPurchaseByKey(key);
  }

  Future dispose() async {
    _purchaseUpdatedSubscription?.cancel();
    _purchaseUpdatedSubscription = null;
    _purchaseErrorSubscription?.cancel();
    _purchaseErrorSubscription = null;

    await FlutterInappPurchase.instance.endConnection;
  }
}
