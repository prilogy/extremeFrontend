import 'dart:ui';

import 'package:extreme/kindOfSport.dart';
import 'package:extreme/playList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Вторая страница - Просмотр (Browse в bottomNavigationBar)

class BrowseScreen extends StatelessWidget {
  final String text;

  // receive data from the FirstScreen as a parameter
  BrowseScreen({Key key, @required this.text}) : super(key: key);

  void _searchIconAction() {
    // Search some video function
    print('tapped');
  }

  @override
  Widget build(BuildContext context) {
    double screenWigth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
        title: Text('Просмотр'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: _searchIconAction,
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(14, 11, 38, 1),
        child: ListView( // Горизонтальный скролл
          padding: const EdgeInsets.all(0.0),
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

            // Карточки с видами спорта
            RowKindCard(),
            // Карточки с видами спорта
            RowKindCard(),
            // Карточки с видами спорта
            RowKindCard(),


            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
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
        ),
      ),
    );
  }
}

// Карточка с популярным плейлистом
class PopularPlayListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 200;
    return Card(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlaylistScreen(),
          ));
        },
        child: Container(
          width: screenWigth / 2,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                width: screenWigth,
                height: cardHeigth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
              ),
              Positioned(
                width: screenWigth,
                height: cardHeigth,
                top: 0,
                left: 0,
                child: Container(
                  color: Color.fromRGBO(14, 11, 38, 0.53),
                ),
              ),

              Positioned(
                left: 0,
                bottom: 20,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                              size: 20,
                              color: Color.fromRGBO(182, 181, 189, 1),
                            ),
                            tooltip: 'Placeholder',
                            onPressed: () {},
                          ),
                          Text(
                            "1555",
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 14.0,
                              color: Color.fromRGBO(182, 181, 189, 1),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.local_movies,
                              size: 20,
                              color: Color.fromRGBO(182, 181, 189, 1),
                            ),
                            tooltip: 'Placeholder',
                            onPressed: () {},
                          ),
                          Text(
                            "89",
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 14.0,
                              color: Color.fromRGBO(182, 181, 189, 1),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Название плейлиста",
                              style: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Краткое описание плейлиста",
                              style: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontSize: 16.0,
                                color: Color.fromRGBO(182, 181, 189, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Color.fromRGBO(182, 181, 189, 1),
                    ),
                    tooltip: 'Placeholder',
                    onPressed: () {},
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// Карточка с видом спорта
class KindCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 90;
    return Card(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
          Navigator.push(context, MaterialPageRoute(
          builder: (context) => KindOfSportScreen(),
      ));
        },
        child: Container(
          width: screenWigth / 2 - 15,
          height: cardHeigth,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                width: screenWigth / 2 - 15,
                height: cardHeigth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
              ),
              Positioned(
                width: screenWigth / 2 - 15,
                height: cardHeigth,
                top: 0,
                left: 0,
                child: Container(
                  color: Color.fromRGBO(14, 11, 38, 0.5),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.playlist_play,
                          color: Color.fromRGBO(182, 181, 189, 1),
                        ),
                        tooltip: 'Placeholder',
                        onPressed: () {},
                      ),
                      Text(
                        "10",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15.0,
                          color: Color.fromRGBO(182, 181, 189, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "89",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15.0,
                          color: Color.fromRGBO(182, 181, 189, 1),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.local_movies,
                            color: Color.fromRGBO(182, 181, 189, 1)),
                        tooltip: 'Placeholder',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30,
                right: 30,
                top: 10,
                bottom: 10,
                child: Container(
//                  alignment: Alignment.center,
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                  child: Text(
                    "Вид спорта",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Строка с карточками видов спорта
class RowKindCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        KindCard(),
        KindCard(), //
      ],
    );
  }
}
