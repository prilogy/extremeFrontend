import 'dart:ui';
import 'package:extreme/config/env.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/screens/kind_of_sport.dart';
import 'package:extreme/playList.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'file:///D:/flutter-dev/extremeFrontend/lib/store/info.dart' as Redux;

// Вторая страница - Просмотр (Browse в bottomNavigationBar)

class BrowseScreen extends StatelessWidget
    implements IWithNavigatorKey {
  Key navigatorKey;

  BrowseScreen({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
        appBar: appBar,
        navigatorKey: navigatorKey,
        builder: (context) => [
              Container(
                margin: EdgeInsets.only(bottom: Indents.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CategoryButton(
                        text: "Плейлисты",
                        icon: Icons.playlist_play,
                        pushTo: PlaylistScreen()),
                    CategoryButton(
                        text: "Фильмы",
                        icon: Icons.movie,
                        pushTo: KindOfSportScreen())
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

class CategoryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget pushTo;

  CategoryButton({this.text, this.icon, this.pushTo});

  @override
  Widget build(BuildContext context) {
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => pushTo,
              ));
            },
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
