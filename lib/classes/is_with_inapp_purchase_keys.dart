import 'dart:io';

abstract class IsWithInAppPurchaseKeys {
  String? appleInAppPurchaseKey;
  String? googleInAppPurchaseKey;

  String? getPlatformKey() => Platform.isIOS ? appleInAppPurchaseKey : Platform.isAndroid ? googleInAppPurchaseKey : null;
}