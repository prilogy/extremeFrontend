import 'package:extreme/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/list_view_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;

class Playlists extends StatelessWidget {
  //const Playlists({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
      appBar: AppBar(title: Text('Плейлисты')),
      builder: (context) => [
        FutureBuilder(
          future: Api.Entities.playlists(1, 10),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return BlockBaseWidget(
                  margin: EdgeInsets.only(bottom: 0),
                  child: CustomListBuilder<Models.Playlist>(
                      type: CustomListBuilderTypes.verticalList,
                      items: snapshot.data,
                      itemBuilder: (item) =>
                          PlayListCard(model: item, aspectRatio: 16 / 9)));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
      ],
    );
  }
}
