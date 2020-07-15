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
        color: Color.fromRGBO(21, 22, 43, 1),
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
              padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
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
    ThemeData theme = Theme.of(context);
    // This partialTheme is incomplete: it only has the title style
    // defined. Just replacing theme.textTheme with partialTheme would
    // set the title, but everything else would be null. This isn't very
    // useful, so merge it with the existing theme to keep all of the
    // preexisting definitions for the other styles.
    TextTheme partialTheme = TextTheme(caption: TextStyle(color: Colors.white));
    theme = theme.copyWith(textTheme: theme.textTheme.merge(partialTheme));
    double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 200;
    return Card(
      margin: EdgeInsets.fromLTRB(20, 12, 20, 8),
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
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                  color: Color.fromRGBO(21, 22, 43, 0.53),
                ),
              ),

              Positioned(
                left: 0,
                bottom: 20,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(0, 10, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          PlayListStats(icon: Icons.thumb_up, text:'1555'),
                          PlayListStats(icon: Icons.local_movies, text:'89'),
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
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                                fontSize: 20.0,
                                color: Colors.white,
                                
                              ),
                            ),
                            Text(
                              "Краткое описание плейлиста",
                              style: Theme(data: theme, child: null),
                              
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
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
          width: screenWigth / 2 - 30,
          height: cardHeigth,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                width: screenWigth / 2 - 15,
                height: cardHeigth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      Container(
                        margin: EdgeInsets.fromLTRB(4, 4, 0, 4),
                        child: Icon(Icons.playlist_play,
                            color: Colors.white),
                      ),
                      Text(
                        "10",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15.0,
                          color: Colors.white,
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
                        "189",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4),
                        child: Icon(Icons.local_movies,
                            color: Colors.white),
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
// Иконка + количество
class PlayListStats extends StatelessWidget {
  final IconData icon;
  final String text;
  const PlayListStats({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        IconButton(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(0),
          icon: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
          tooltip: 'Placeholder',
          onPressed: () {},
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 14.0,
            color: Colors.white,
          ),
        ),
      ], 
    );
  }
}