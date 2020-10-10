import 'package:extreme/helpers/custom_paginated_list_callback.dart';
import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/screens/main_screen/account_screen/helper.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:flutter/painting.dart';

final _config = <PaginatedScreenTab>[
  PaginatedScreenTab(
    localizationKey: 'videos',
    itemListCallback: CustomPaginatedListCallback<Video>(
        itemsGetter: (page, pageSize) async {
          return await processIds<Video>(store.state.user.saleIds.videos, page, pageSize, (id, e) => id == e.id);
        },
        itemBuilder: (model) => VideoCard(
          model: model[0],
        )),
  ),
  PaginatedScreenTab(
      localizationKey: 'movies',
      itemListCallback: CustomPaginatedListCallback<Movie>(
        pageSize: 6,
        itemsGetter: (page, pageSize) async {
          return await processIds<Movie>(store.state.user.saleIds.movies, page, pageSize, (id, e) => id == e.id);
        },
        modelListSize: 3,
        itemBuilder: (data) => CustomListBuilder(
            childAspectRatio: 9 / 16,
            type: CustomListBuilderTypes.grid,
            crossAxisCount: 3,
            items: data,
            itemBuilder: (item) => MovieCard(model: item)),
      )),
  PaginatedScreenTab(
      localizationKey: 'playlists',
      itemListCallback: CustomPaginatedListCallback<Playlist>(
          itemsGetter: (page, pageSize) async {
            return await processIds<Playlist>(store.state.user.saleIds.playlists, page, pageSize, (id, e) => id == e.id);
          },
          itemBuilder: (model) => PlayListCard(
            aspectRatio: 16 / 9,
            model: model[0],
          )))
];

class SaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context).withBaseKey('sale_screen');

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
