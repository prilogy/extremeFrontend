import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/container_centered_with_max_width.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef WidgetBuilderChildren = List<Widget> Function(BuildContext context);
typedef AppBarBuilderComplex = Widget Function(
    BuildContext context, ScrollController controller);

class ScreenBaseWidget extends StatefulWidget with IndentsMixin {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool maxWidthAndCenter;

  final AppBar? appBar;
  final WidgetBuilderChildren? builder;
  final WidgetBuilder? builderChild;
  final Key? navigatorKey;
  final Future Function()? onRefresh;
  final bool? forceDefaultAppBar;

  static const double screenBottomIndent = NavBar.height + 2 * Indents.md;

  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(top: Indents.md, bottom: screenBottomIndent);

  ScreenBaseWidget(
      {this.padding = defaultPadding,
      this.margin,
      this.appBar,
      this.forceDefaultAppBar,
      this.builder,
      this.builderChild,
      this.navigatorKey,
      this.maxWidthAndCenter = true,
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
        appBar: widget.appBar ?? EmptyAppBar(),
        body: Builder(
          builder: (context) {
            var res = (widget.builder == null
                ? widget.builderChild?.call(context)
                : widget.builder?.call(context)) as dynamic;

            return SafeArea(
                top: true,
                left: true,
                right: true,
                bottom: true,
                child: Center(
                  child: ContainerCenteredWithMaxWidth(
                      maxWidth: widget.maxWidthAndCenter == true
                          ? ContainerCenteredWithMaxWidth.constMaxWidth
                          : null,
                      child: widget.builder == null
                          ? res
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
                                      children: [
                                        Column(children: res as dynamic)
                                      ]),
                                )
                              : ListView(
                                  controller: _scrollController,
                                  padding: widget.padding,
                                  children: [
                                      Column(children: res as dynamic)
                                    ])),
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
