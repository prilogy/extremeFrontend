import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_pagination_helper/pagination_helper/event_model.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';
import 'package:flutter_pagination_helper/pagination_helper/list_helper.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:extreme/services/api/main.dart' as Api;

class FavoriteScreenTab {
  final String localizationKey;
  final FavoriteScreenTabView view;
  final ItemListCallback itemListCallback;

  FavoriteScreenTab({this.localizationKey, this.itemListCallback})
      : view = FavoriteScreenTabView(
          itemListCallback: itemListCallback,
        );
}

class FavoriteScreenTabView extends StatefulWidget {
  final ItemListCallback itemListCallback;

  FavoriteScreenTabView({this.itemListCallback});

  @override
  _FavoriteScreenTabViewState createState() => _FavoriteScreenTabViewState();
}

class _FavoriteScreenTabViewState extends State<FavoriteScreenTabView>
    with AutomaticKeepAliveClientMixin<FavoriteScreenTabView> {
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PaginatedListWidget(
      itemListCallback: widget.itemListCallback,
    );
  }
}

final _config = <FavoriteScreenTab>[
  FavoriteScreenTab(
    localizationKey: 'videos',
    itemListCallback: CustomPaginatedListCallback<Video>(
        itemsGetter: (page) async {
          return Api.Entities.getAll<Video>(page, 5);
        },
        itemBuilder: (model) => VideoCard(
              model: model,
            )),
  ),
  FavoriteScreenTab(
      localizationKey: 'movies',
      itemListCallback: CustomPaginatedListCallback<Video>(
          itemsGetter: (page) async {
            return Api.Entities.getAll<Video>(page, 5);
          },
          itemBuilder: (model) => VideoCard(
                model: model,
              ))),
  FavoriteScreenTab(
      localizationKey: 'playlists',
      itemListCallback: CustomPaginatedListCallback<Playlist>(
          itemsGetter: (page) async {
            return Api.Entities.getAll<Playlist>(page, 5);
          },
          itemBuilder: (model) => PlayListCard(
                model: model,
              ))),
  FavoriteScreenTab(
      localizationKey: 'sports',
      itemListCallback: CustomPaginatedListCallback<Sport>(
          itemsGetter: (page) async {
            return Api.Entities.getAll<Sport>(page, 4);
          },
          itemBuilder: (model) => Container(
            height: 100,
            child: SportCard(
                  model: model,
                ),
          )))
];

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context).withBaseKey('favorite_screen');

    return DefaultTabController(
      length: _config.length,
      child: ScreenBaseWidget(
        padding: EdgeInsets.all(0),
        appBar: AppBar(
          title: Text(loc.translate('app_bar')),
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              for (var item in _config)
                Tab(
                  text: HelperMethods.capitalizeString(
                      AppLocalizations.of(context)
                          .translate('base.' + item.localizationKey)),
                )
            ],
          ),
        ),
        builderChild: (context) => TabBarView(
          children: <Widget>[for (var item in _config) item.view],
        ),
      ),
    );
  }
}

typedef ItemBuilder<T> = Widget Function(T model);
typedef PagingItemsGetter<T> = Future<List<T>> Function(int page);

class CustomPaginatedListCallback<T> extends ItemListCallback {
  int page = 1;

  final PagingItemsGetter<T> itemsGetter;
  final double bottomIndent;
  final double gap;
  final VoidCallback onStopLoading;

  CustomPaginatedListCallback(
      {this.itemBuilder,
      this.itemsGetter,
      this.onStopLoading,
      this.bottomIndent = ScreenBaseWidget.screenBottomIndent,
      this.gap = Indents.md});

  final ItemBuilder<T> itemBuilder;

  @override
  Future<EventModel> getItemList() async {
    var items = await itemsGetter(page);
    page++;

    var widgets = <Widget>[];

    if (items.length == 0) {
      widgets.add(Container(height: bottomIndent));
      onStopLoading?.call();
      return EventModel(
          data: widgets, error: null, progress: false, stopLoading: true);
    }

    for (var item in items) {
      widgets.add(BlockBaseWidget(
        child: itemBuilder(item),
        margin: EdgeInsets.only(top: gap),
      ));
    }

    return EventModel(
        data: widgets, error: null, progress: false, stopLoading: false);
  }
}
