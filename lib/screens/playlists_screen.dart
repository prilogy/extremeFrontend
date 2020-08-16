import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;

class Playlists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
      appBar: AppBar(title: Text('Плейлисты')),
      builder: (context) => [
        CustomFutureBuilder<List<Models.Playlist>>(
            future: Api.Entities.getAll<Models.Playlist>(1, 10),
            builder: (List<Models.Playlist> data) => BlockBaseWidget(
                margin: EdgeInsets.only(bottom: 0),
                child: CustomListBuilder<Models.Playlist>(
                    type: CustomListBuilderTypes.verticalList,
                    items: data,
                    itemBuilder: (item) =>
                        PlayListCard(model: item, aspectRatio: 16 / 9)))),
      ],
    );
  }
}
