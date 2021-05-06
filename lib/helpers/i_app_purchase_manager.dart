import 'dart:async';

import 'package:collection/collection.dart';
import 'package:extreme/classes/is_with_inapp_purchase_keys.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_inapp_purchase/modules.dart';

class IAppPurchaseManager {
  List<IAPItem>? _iapProducts;
  StreamSubscription<PurchasedItem?>? _purchaseUpdatedSubscription;
  StreamSubscription<PurchaseResult?>? _purchaseErrorSubscription;

  List<String>? productKeys;
  void Function(PurchasedItem?)? onUpdated;
  void Function(PurchaseResult?)? onError;

  IAppPurchaseManager({this.productKeys, this.onError, this.onUpdated});

  Future init(List<String> productKeys) async {
    await FlutterInappPurchase.instance.initConnection;
    _setupListeners();
    print(await FlutterInappPurchase.instance.clearTransactionIOS() ?? "");
    _iapProducts = await FlutterInappPurchase.instance.getProducts(productKeys);
    var product =
        _iapProducts?.firstWhereOrNull((x) => x.productId == 'P_MINIMUM');
    if (product != null) requestPurchase(product);
  }

  void _setupListeners() {
    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen(onUpdated);
    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen(onError);
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
    var item = _iapProducts?.firstWhereOrNull((x) => x.productId == key);
    if (item == null) return false;
    return requestPurchase(item);
  }

  bool requestPurchaseBy(IsWithInAppPurchaseKeys item) {
    var key = item.getPlatformKey();
    return key == null ? false : requestPurchaseByKey(key);
  }

  Future dispose() async {
    _purchaseUpdatedSubscription?.cancel();
    _purchaseUpdatedSubscription = null;
    _purchaseErrorSubscription?.cancel();
    _purchaseErrorSubscription = null;

    await FlutterInappPurchase.instance.endConnection;
  }
}
