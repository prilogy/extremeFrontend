import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef WidgetBuilderChildren = List<Widget> Function(BuildContext context);
typedef AppBarBuilderComplex = Widget Function(
    BuildContext context, ScrollController controller);

class ScreenBaseWidget extends StatefulWidget with IndentsMixin {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final Widget appBar;
  final AppBarBuilderComplex appBarComplex;
  final WidgetBuilderChildren builder;
  final WidgetBuilder builderChild;
  final Key navigatorKey;
  final Future Function() onRefresh;

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
      this.navigatorKey,
      this.appBarComplex,
      this.onRefresh});

  @override
  _ScreenBaseWidgetState createState() => _ScreenBaseWidgetState();
}

class _ScreenBaseWidgetState extends State<ScreenBaseWidget> {
  var _refreshController = RefreshController(initialRefresh: false);
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content(BuildContext ctx) {
      return Scaffold(
        appBar: widget.appBar != null
            ? widget.appBar
            : widget.appBarComplex != null
                ? widget.appBarComplex(ctx, _scrollController)
                : EmptyAppBar(),
        body: Builder(
          builder: (context) {
            var res = widget.builder == null
                ? widget.builderChild(context)
                : widget.builder(context);

            return SafeArea(
                top: true,
                left: true,
                right: true,
                bottom: true,
                child: widget.builder == null
                    ? Container(padding: widget.padding, child: res)
                    : widget.onRefresh != null
                        ? SmartRefresher(
                            controller: _refreshController,
                            enablePullUp: false,
                            onRefresh: () async {
                              await widget.onRefresh?.call();
                              _refreshController.refreshCompleted();
                            },
                            header: MaterialClassicHeader(),
                            child: ListView(
                              controller: _scrollController,
                              padding: widget.padding,
                              children: res,
                            ),
                          )
                        : ListView(
                            controller: _scrollController,
                            padding: widget.padding,
                            children: res,
                          ));
          },
        ),
      );
    }

    if (widget.navigatorKey != null)
      return Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: (context) => MaterialPageRoute(
          builder: (context) => content(context),
        ),
      );

    return content(context);
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}
