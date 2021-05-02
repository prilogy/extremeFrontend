import 'package:extreme/helpers/custom_paginated_list_callback.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:loadmore/loadmore.dart';

typedef LinqForT<T> = bool Function(int, T);

Future<List<T>> processIds<T>(
    List<EntityIdItem> ids, int page, int pageSize, LinqForT<T> linq) async {
  ids.sort((a, b) => a.id.compareTo(b.id));
  ids = ids.reversed.toList();
  var idsInt = ids.map<int>((e) => e.entityId).toList();
  var data = await Api.Entities.getByIds<T>(idsInt, page, pageSize);
  return idsInt.map<T>((e) => data.firstWhere((y) => linq(e, y))).toList();
}

class PaginatedScreenTab {
  final String localizationKey;
  final PaginatedScreenTabView view;
  final CustomPaginatedListCallback itemListCallback;

  PaginatedScreenTab({this.localizationKey, this.itemListCallback})
      : view = PaginatedScreenTabView(
          itemListCallback: itemListCallback,
        );
}

class PaginatedScreenTabView extends StatefulWidget {
  final CustomPaginatedListCallback itemListCallback;

  PaginatedScreenTabView({this.itemListCallback});

  @override
  _PaginatedScreenTabViewState createState() => _PaginatedScreenTabViewState();
}

class _PaginatedScreenTabViewState extends State<PaginatedScreenTabView>
    with AutomaticKeepAliveClientMixin<PaginatedScreenTabView> {
  @override
  bool get wantKeepAlive => true;

  CustomPaginatedListCallback itemListCallback;

  @override
  void initState() {
    super.initState();
    itemListCallback = widget.itemListCallback;
  }

  @override
  void dispose() {
    itemListCallback.page = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      child: LoadMore(
        isFinish: itemListCallback.isFinished,
        onLoadMore: itemListCallback.load,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => Container(
              child:
                  itemListCallback.itemBuilder(itemListCallback.items[index])),
          itemCount: itemListCallback.items.length,
        ),
        whenEmptyLoad: false,
        delegate: DefaultLoadMoreDelegate(),
        textBuilder: DefaultLoadMoreTextBuilder.chinese,
      ),
      onRefresh: itemListCallback.refresh,
    );

    // return PaginatedListWidget(
    //   progressWidget: Container(
    //     padding: EdgeInsets.symmetric(vertical: Indents.lg),
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    //   itemListCallback: widget.itemListCallback,
    // );
  }
}
