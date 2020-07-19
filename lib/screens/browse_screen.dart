import 'dart:ui';
import 'package:extreme/config/env.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/models/api_image.dart';
import 'package:extreme/models/sport.dart';
import 'package:extreme/playList.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/redux.dart' as Redux;

// Вторая страница - Просмотр (Browse в bottomNavigationBar)

class BrowseScreen extends StatelessWidget implements HasAppBar {
  @override
  final Widget appBar = AppBar(
    title: Text("Просмотр"),
    actions: <Widget>[
      new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {
          print("smth");
        },
      ),
    ],
  );

  BrowseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Widget categoryButton(String text, IconData icon, Widget pushTo) {
      return Container(
        padding: const EdgeInsets.all(Indents.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 50,
              icon: Icon(icon, color: Colors.white),
              tooltip: text,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pushTo,
                    ));
              },
            ),
            Text(
              text,
              style: theme.textTheme.bodyText2,
            ),
          ],
        ),
      );
    }

    return ScreenBaseWidget(appBar: appBar, children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: Indents.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            categoryButton("Плейлисты", Icons.playlist_play, PlaylistScreen()),
            categoryButton("Фильмы", Icons.movie, PlaylistScreen())
          ],
        ),
      ),
      BlockBaseWidget(
        child: GridView.count(
          primary: false,
          crossAxisSpacing: Indents.md,
          mainAxisSpacing: Indents.md,
          childAspectRatio: 16 / 9,
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            for (var item in [
              SportCard(
                title: 'F1',
                playlists: 23,
                videos: 142,
              ),
              SportCard(
                title: 'Вид спорта',
                playlists: 2,
                videos: 12240,
              ),
              SportCard(
                title: 'Другой вид спорта',
                playlists: 19000,
                videos: 2122212,
              )
            ])
              item
          ],
        ),
      ),
      BlockBaseWidget(
        header: "Популярные плейлисты",
        margin: EdgeInsets.zero,
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            for (var item in [
              PlayListCard(
                aspectRatio: 16 / 9,
                padding: EdgeInsets.only(bottom: Indents.md),
                title: 'Название плейлиста',
                description: 'Краткое описание плейлиста',
                likes: 1555,
                videos: 43,
                isLiked: false,
              ),
              PlayListCard(
                aspectRatio: 16 / 9,
                padding: EdgeInsets.only(bottom: Indents.md),
                title: 'Название другого плейлиста',
                description: 'Краткое описание другого плейлиста',
                likes: 123,
                videos: 12,
                isLiked: true,
              ),
            ])
              item
          ],
        ),
      ),
    ]);
  }
}
