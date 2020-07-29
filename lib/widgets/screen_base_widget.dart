import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

typedef WidgetBuilderChildren = List<Widget> Function(BuildContext context);

class ScreenBaseWidget extends StatelessWidget with IndentsMixin {
  final EdgeInsetsGeometry padding;

  final Widget appBar;
  final WidgetBuilderChildren builder;
  final Key navigatorKey;

  static const double screenBottomIndent =
      NavBar.height + Indents.md + Indents.sm;

  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(top: Indents.md, bottom: screenBottomIndent);

  ScreenBaseWidget(
      {this.padding = defaultPadding,
      this.appBar,
      this.builder,
      this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    if (navigatorKey != null)
      return Navigator(
        key: navigatorKey,
        onGenerateRoute: (context) => MaterialPageRoute(
          builder: (context) => Scaffold(
              appBar: appBar,
              body: Builder(
                builder: (context) {
                  var res = builder(context);
                  return ListView(
                    padding: padding,
                    children: res,
                  );
                },
              )),
        ),
      );

    return Scaffold(
        appBar: appBar,
        body: Builder(
          builder: (context) {
            var res = builder(context);
            return ListView(
              padding: padding,
              children: res,
            );
          },
        ));
  }
}
