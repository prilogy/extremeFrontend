import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination_helper/pagination_helper.dart';

typedef ItemBuilder<T> = Widget Function(List<T> model);
typedef PagingItemsGetter<T> = Future<List<T>> Function(int page, int pageSize);

class CustomPaginatedListCallback<T> extends ItemListCallback {
  int page = 1;

  final int modelListSize;
  final PagingItemsGetter<T> itemsGetter;
  final double bottomIndent;
  final double gap;
  final VoidCallback? onStopLoading;
  final int pageSize;
  final WidgetBuilder? noItemsWidgetBuilder;

  CustomPaginatedListCallback(
      {required this.itemBuilder,
        required this.itemsGetter,
        this.pageSize = 6,
        this.noItemsWidgetBuilder,
        this.modelListSize = 1,
        this.onStopLoading,
        this.bottomIndent = ScreenBaseWidget.screenBottomIndent,
        this.gap = Indents.md});

  final ItemBuilder<T> itemBuilder;

  @override
  Future<EventModel> getItemList() async {
    var items = await itemsGetter(page, pageSize);

    var widgets = <Widget>[];

    if (items.length == 0) {
      if (page == 1)
        widgets.add(Builder(
          builder: (context) {
            if(noItemsWidgetBuilder != null)
              return (noItemsWidgetBuilder!.call(context));

            var loc = AppLocalizations.of(context)!;

            return Container(
                padding: EdgeInsets.symmetric(vertical: Indents.lg),
                child: Center(child: Text(loc.translate('helper.empty_list'))));
          },
        ));

      widgets.add(Container(height: bottomIndent));
      onStopLoading?.call();
      page = 1;
      return EventModel(
          data: widgets, error: null, progress: false, stopLoading: true);
    }

    page++;
    var len = items.length;
    var size = modelListSize;

    for (var i = 0; i < len; i += size) {
      var end = (i + size < len) ? i + size : len;
      widgets.add(BlockBaseWidget(
          margin: EdgeInsets.only(top: gap),
          child: itemBuilder(items.sublist(i, end))));
    }

    var noMoreItems = items.length < pageSize;
    if (noMoreItems) widgets.add(Container(height: bottomIndent));

    return EventModel(
        data: widgets, error: null, progress: false, stopLoading: noMoreItems);
  }
}
