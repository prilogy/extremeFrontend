import 'package:extreme/helpers/custom_paginated_list_callback.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;

import 'main_screen/account_screen/helper.dart';

/// Страница со списком фильмов
class MoviesList extends StatelessWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context)?.withBaseKey('browse_screen');

    return ScreenBaseWidget(
      padding: EdgeInsets.all(0),
      appBar: AppBar(title: Text(loc!.translate("movies"))),
      builderChild: (context) => PaginatedScreenTabView(
          itemListCallback: CustomPaginatedListCallback<Movie>(
        pageSize: 6,
        itemsGetter: (page, pageSize) async {
          return await Api.Entities.getAll<Movie>(page, pageSize, "desc");
        },
        modelListSize: 3,
        itemBuilder: (data) => CustomListBuilder(
            childAspectRatio: 9 / 16,
            type: CustomListBuilderTypes.grid,
            crossAxisCount: 3,
            items: data,
            itemBuilder: (item) => MovieCard(model: item as Movie)),
      )),
    );
  }
}
