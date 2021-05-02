import 'package:extreme/helpers/custom_paginated_list_callback.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;

import 'main_screen/account_screen/helper.dart';

class Playlists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('browse_screen');

    return ScreenBaseWidget(
      padding: EdgeInsets.all(0),
      appBar: AppBar(title: Text(loc.translate("playlists"))),
      builderChild: (context) => PaginatedScreenTabView(
        itemListCallback: CustomPaginatedListCallback<Playlist>(
            itemsGetter: (page, pageSize) async {
              return await Api.Entities.getAll<Playlist>(page, pageSize, "desc");
            },
            itemBuilder: (model) => PlayListCard(
                  aspectRatio: 16 / 9,
                  model: model[0],
                )),
      ),
    );
  }
}
