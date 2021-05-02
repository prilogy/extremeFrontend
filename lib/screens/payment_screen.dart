import 'dart:async';

import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentScreen extends StatefulWidget {
  final String? url;
  final String? title;
  final Future Function()? onPaymentDone;
  final bool? closeOnDone;
  final Future Function()? onBrowserClose;

  PaymentScreen(
      {this.url,
      this.title,
      this.onPaymentDone,
      this.closeOnDone = true,
      this.onBrowserClose});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool progressIsActive = true;
  final browser = MyInAppBrowser();
  bool paymentSuccess = false;
  bool browserOpened = false;

  @override
  void didChangeDependencies() {
    browser.onUrlLoadStart = (ctx, url) async {
      browserOpened = true;
      if (url.path.contains('localhost')) {
        setState(() {
          paymentSuccess = true;
        });
        ctx.close();
      }
    };
    browser.onBrowserClose = () async {
      setState(() {
        progressIsActive = true;
      });
      await Future.delayed(Duration(seconds: 5));
      if (paymentSuccess) {
        await widget.onPaymentDone?.call();
      } else
        await widget.onBrowserClose?.call();
      setState(() {
        progressIsActive = false;
      });
      if (widget.closeOnDone!) Navigator.of(context).pop();
    };
    browser.openUrlRequest(urlRequest: URLRequest(url: Uri.parse(widget.url!)));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)?.withBaseKey('payment');
    var store = StoreProvider.of<AppState>(context).state;
    if(!browserOpened && store.settings!.currency != Currency.RUB) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: loc!.translate("warning"),
          backgroundColor: Colors.black.withOpacity(0.5));
    }

    return ScreenBaseWidget(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
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

class MyInAppBrowser extends InAppBrowser {
  void Function(MyInAppBrowser ctx, Uri url)? onUrlLoadStart;
  VoidCallback? onBrowserClose;

  MyInAppBrowser({this.onUrlLoadStart, this.onBrowserClose});

  @override
  void onLoadStart(Uri? url) {
    onUrlLoadStart?.call(this, url!);
  }

  @override
  void onExit() {
    onBrowserClose?.call();
  }
}
