import 'package:extreme/classes/is_with_inapp_purchase_keys.dart';
import 'package:extreme/models/main.dart';

abstract class IsSalable extends IsWithInAppPurchaseKeys {
  bool? isBought;
  Price? price;
}
