import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class PaymentInAppScreen extends StatefulWidget {
  @override
  _PaymentInAppScreenState createState() => _PaymentInAppScreenState();
}

class _PaymentInAppScreenState extends State<PaymentInAppScreen> {

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  void asyncInitState() async {
    await FlutterInappPurchase.instance.initConnection;
  }

  @override
  void dispose() async {
    await FlutterInappPurchase.instance.endConnection;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
