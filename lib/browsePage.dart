import 'dart:ui';

import 'package:extreme/kindOfSport.dart';
import 'package:extreme/playList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
        PopularPlayListCard(),
        // Карточка с популярным плейлистом
        PopularPlayListCard(),
        // Карточка с популярным плейлистом
        PopularPlayListCard(),
      ],
    );
  }
}

// Карточка с популярным плейлистом
class PopularPlayListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    TextTheme partialTheme = TextTheme(caption: TextStyle(color: Colors.white));
    theme = theme.copyWith(textTheme: theme.textTheme.merge(partialTheme));
    double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 200;
    return Card(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 8),
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaylistScreen(),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage("extreme2.jpg"),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [Color(0x5009042c), Color(0xA209042c)],
                          center: Alignment.center,
                          radius: 1,
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.all(12),
                                icon: Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                  color: Color.fromRGBO(182, 181, 189, 1),
                                ),
                                tooltip: 'Placeholder',
                                onPressed: () {},
                              ),
                            ]),
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 12),
                                      child: Stats(
                                        icon: Icons.thumb_up,
                                        text: '1555',
                                        iconMarginRight: 5,
                                      ),
                                    ),
                                    Stats(
                                        icon: Icons.local_movies,
                                        text: '89',
                                        iconMarginRight: 5),
                                  ],
                                ),
                                Text(
                                  "Название плейлиста",
                                  style: TextStyle(
                                    letterSpacing: 0.8,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "Достаточно Краткое описание плейлиста",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .merge(
                                          new TextStyle(color: Colors.white)),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ],
                ),
                width: screenWigth,
                height: cardHeigth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

