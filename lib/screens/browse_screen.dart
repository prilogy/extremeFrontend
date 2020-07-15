import 'dart:ui';
import 'package:extreme/playList.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:flutter/material.dart';

// Вторая страница - Просмотр (Browse в bottomNavigationBar)

class BrowseScreen extends StatelessWidget {
  BrowseScreen({Key key}) : super(key: key);

  void _searchIconAction() {
    print('tapped');
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Widget CategoryButton(String text, IconData icon, Widget pushTo) {
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

    //      appBar: AppBar(
//        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
//        title: Text('Просмотр'),
//        actions: <Widget>[
//          new IconButton(
//            icon: new Icon(Icons.search),
//            onPressed: _searchIconAction,
//          ),
//        ],
//      ),

    return ListView(
      padding: EdgeInsets.all(12),
      // Горизонтальный скролл
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Кнопка плейлистов с подписью
            // Кнопка фильмы с подписью
            CategoryButton("Плейлисты", Icons.playlist_play, PlaylistScreen()),
            CategoryButton("Фильмы", Icons.movie, PlaylistScreen())
          ],
        ),

        GridView.count(
          primary: false,
          crossAxisSpacing: 10,
          childAspectRatio: 16 / 9,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          crossAxisCount: 2,
          children: <Widget>[SportCard(), SportCard(), SportCard()],
        ),

        Container(
          padding: EdgeInsets.fromLTRB(0, 20, 5, 0),
          child: Text(
            'Популярные плейлисты',
            style: TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),

        // Карточка с популярным плейлистом
        AspectRatio(aspectRatio: 16 / 9, child: PlayListCard()),
        // Карточка с популярным плейлистом
        PlayListCard(),
        // Карточка с популярным плейлистом
        PlayListCard(),
      ],
    );
  }
}
