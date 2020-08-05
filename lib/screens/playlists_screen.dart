import 'package:extreme/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/list_view_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
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
        BlockBaseWidget(
          //header: "Популярные плейлисты",
          child: FutureBuilder(
            future: Api.Entities.playlists(1, 4),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListGenerator<Models.Playlist>(
                  models: snapshot.data,
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),
      ],
    );
  }
}
