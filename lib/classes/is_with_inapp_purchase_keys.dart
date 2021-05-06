import 'dart:io';

abstract class IsWithInAppPurchaseKeys {
  int? id;
  String? appleInAppPurchaseKey;
  String? googleInAppPurchaseKey;

  String? get productId => Platform.isIOS
      ? appleInAppPurchaseKey
      : Platform.isAndroid
          ? googleInAppPurchaseKey
          : null;
}

extension PurchaseExtension on List<IsWithInAppPurchaseKeys> {
  List<String> get productKeys {
    var isIos = Platform.isIOS
        ? true
        : Platform.isAndroid
            ? false
            : null;
    if (isIos == null) return [];
    return this
        .map((e) => isIos ? e.appleInAppPurchaseKey : e.googleInAppPurchaseKey)
        .toList()
        .where((e) => e != null)
        .cast<String>()
        .toList();
  }
}
