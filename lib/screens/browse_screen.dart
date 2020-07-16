import 'dart:ui';
import 'package:extreme/config/env.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/models/sport.dart';
import 'package:extreme/playList.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(10.0),
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
          childAspectRatio: 16/9,
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            for (var item in [
              SportCard(),
              SportCard(),
              SportCard()
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
              ),
              PlayListCard()
            ])
              item
          ],
        ),
      ),
    ]);
  }
}
