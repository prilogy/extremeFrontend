import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

typedef WidgetBuilderChildren = List<Widget> Function(BuildContext context);

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

class ScreenBaseWidget extends StatelessWidget with IndentsMixin {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final Widget appBar;
  final WidgetBuilderChildren builder;
  final WidgetBuilder builderChild;
  final Key navigatorKey;

  static const double screenBottomIndent =
      NavBar.height + Indents.md + Indents.sm;

  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(top: Indents.md, bottom: screenBottomIndent);

  ScreenBaseWidget(
      {this.padding = defaultPadding,
      this.margin,
      this.appBar,
      this.builder,
      this.builderChild,
      this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    Widget content(BuildContext ctx) {
      return Scaffold(
          appBar: appBar ?? EmptyAppBar(),
          body: Builder(
            builder: (context) {
              var res =
                  builder == null ? builderChild(context) : builder(context);

              return SafeArea(
                  top: true,
                  left: true,
                  right: true,
                  bottom: true,
                  child: builder == null
                      ? Container(padding: padding, child: res)
                      : ListView(
                          padding: padding,
                          children: res,
                        ));
            },
          ));
    }

    if (navigatorKey != null)
      return Navigator(
        key: navigatorKey,
        onGenerateRoute: (context) => MaterialPageRoute(
          builder: (context) => content(context),
        ),
      );

    return content(context);
  }
}
