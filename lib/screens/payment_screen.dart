import 'dart:async';

import 'package:extreme/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentScreen extends StatefulWidget {
  final String url;
  final String title;
  final Future Function()  onPaymentDone;

  PaymentScreen({this.url, this.title, this.onPaymentDone});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  bool progressIsActive;

  @override
  void initState() {
    super.initState();
  }

  // TODO: Доделать
  @override
  Widget build(BuildContext context) {
    final browser = MyInAppBrowser(
        onUrlLoadStart: (ctx, url) async {
          if(url.contains('localhost')) {
            ctx.close();
            setState(() {
              progressIsActive = true;
            });
            await widget.onPaymentDone;
            setState(() {
              progressIsActive = false;
            });
          }
        }
    );
    browser.setOptions(options: InAppBrowserClassOptions(crossPlatform: InAppBrowserOptions(toolbarTopBackgroundColor: Theme.of(context).backgroundColor.toString())));
    browser.openUrl(url: widget.url);

    return ScreenBaseWidget(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      builderChild: (context) => BlockBaseWidget(
        padding: EdgeInsets.symmetric(vertical: Indents.xl),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class MyInAppBrowser extends InAppBrowser {
  final void Function(MyInAppBrowser ctx, String url) onUrlLoadStart;
  final VoidCallback onBrowserClose;


  MyInAppBrowser({this.onUrlLoadStart, this.onBrowserClose});

  @override
  Future onLoadStart(String url) async {
    print(url);
    onUrlLoadStart?.call(this, url);
  }

  @override
  void onExit() {
    onBrowserClose?.call();
  }
}