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
  final Future Function() onPaymentDone;
  final bool closeOnDone;
  final Future Function() onBrowserClose;

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
  bool progressIsActive;
  final browser = MyInAppBrowser();

  @override
  void didChangeDependencies() {
    browser.onUrlLoadStart = (ctx, url) async {
      if (url.contains('localhost')) {
        ctx.close();
        setState(() {
          progressIsActive = true;
        });
        await widget.onPaymentDone?.call();
        setState(() {
          progressIsActive = false;
        });
      }
    };
    browser.onBrowserClose = () async {
      setState(() {
        progressIsActive = true;
      });
      await widget.onBrowserClose?.call();
      setState(() {
        progressIsActive = false;
      });
      if (widget.closeOnDone) Navigator.of(context).pop();
    };
    browser.openUrl(url: widget.url);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
  void Function(MyInAppBrowser ctx, String url) onUrlLoadStart;
  VoidCallback onBrowserClose;

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
