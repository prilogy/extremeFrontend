import 'dart:ui';

import 'package:extreme/kindOfSport.dart';
import 'package:extreme/playList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'widgets/playlist_card.dart';
import 'widgets/sport_card.dart';
import 'widgets/stats.dart';

// Вторая страница - Просмотр (Browse в bottomNavigationBar)

class BrowseScreen extends StatelessWidget {
  // receive data from the FirstScreen as a parameter
  BrowseScreen({Key key}) : super(key: key);

  void _searchIconAction() {
    // Search some video function
    print('tapped');
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.playlist_play,
                        color: Color.fromRGBO(182, 181, 189, 1)),
                    tooltip: 'Placeholder',
                    onPressed: () {
                      print("Плейлист");
                    },
                  ),
                  Text(
                    "Плейлисты",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 15.0,
                      color: Color.fromRGBO(182, 181, 189, 1),
                    ),
                  ),
                ],
              ),
            ),

            // Кнопка фильмы с подписью
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.videocam,
                        color: Color.fromRGBO(182, 181, 189, 1)),
                    tooltip: 'Placeholder',
                    onPressed: () {
                      print("Фильмы");
                    },
                  ),
                  Text(
                    "Фильмы",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 15.0,
                      color: Color.fromRGBO(182, 181, 189, 1),
                    ),
                  ),
                ],
              ),
            ),
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
        PlayListCard(),
        // Карточка с популярным плейлистом
        PlayListCard(),
        // Карточка с популярным плейлистом
        PlayListCard(),
      ],
    );
  }
}

