import 'package:extreme/helpers/custom_paginated_list_callback.dart';
import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_pagination_helper/pagination_helper/item_list_callback.dart';
import 'package:flutter_pagination_helper/pagination_helper/list_helper.dart';
import 'package:extreme/services/api/main.dart' as Api;

typedef LinqForT<T> = bool Function(int, T);

Future<List<T>> processIds<T>(List<EntityIdItem> ids, int page, int pageSize, LinqForT<T> linq) async {
  ids.sort((a, b) => a.id.compareTo(b.id));
  ids = ids.reversed.toList();
  var idsInt = ids.map<int>((e) => e.entityId).toList();
  var data = await Api.Entities.getByIds<T>(idsInt, page, pageSize);
  return idsInt.map<T>((e) => data.firstWhere((y) => linq(e,y))).toList();
}


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

    return PaginatedListWidget(
      progressWidget: Container(
        padding: EdgeInsets.symmetric(vertical: Indents.lg),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      itemListCallback: widget.itemListCallback,
    );
  }
}

final _config = <FavoriteScreenTab>[
  FavoriteScreenTab(
    localizationKey: 'videos',
    itemListCallback: CustomPaginatedListCallback<Video>(
        itemsGetter: (page, pageSize) async {
          return await processIds<Video>(store.state.user.favoriteIds.videos, page, pageSize, (id, e) => id == e.id);
        },
        itemBuilder: (model) => VideoCard(
              model: model[0],
            )),
  ),
  FavoriteScreenTab(
      localizationKey: 'movies',
      itemListCallback: CustomPaginatedListCallback<Movie>(
        pageSize: 6,
        itemsGetter: (page, pageSize) async {
          return await processIds<Movie>(store.state.user.favoriteIds.movies, page, pageSize, (id, e) => id == e.id);
        },
        modelListSize: 3,
        itemBuilder: (data) => CustomListBuilder(
            childAspectRatio: 9 / 16,
            type: CustomListBuilderTypes.grid,
            crossAxisCount: 3,
            items: data,
            itemBuilder: (item) => MovieCard(model: item)),
      )),
  FavoriteScreenTab(
      localizationKey: 'playlists',
      itemListCallback: CustomPaginatedListCallback<Playlist>(
          itemsGetter: (page, pageSize) async {
            return await processIds<Playlist>(store.state.user.favoriteIds.playlists, page, pageSize, (id, e) => id == e.id);
          },
          itemBuilder: (model) => PlayListCard(
                aspectRatio: 16 / 9,
                model: model[0],
              ))),
  FavoriteScreenTab(
      localizationKey: 'sports',
      itemListCallback: CustomPaginatedListCallback<Sport>(
        modelListSize: 2,
        itemsGetter: (page, pageSize) async {
          return await processIds<Sport>(store.state.user.favoriteIds.sports, page, pageSize, (id, e) => id == e.id);
        },
        itemBuilder: (data) => CustomListBuilder(
            childAspectRatio: 16 / 9,
            type: CustomListBuilderTypes.grid,
            crossAxisCount: 2,
            items: data,
            itemBuilder: (item) => SportCard(model: item)),
      ))
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
