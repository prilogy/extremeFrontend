import 'package:extreme/videoViewPage.dart';
import 'package:extreme/widgets/film_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'widgets/playlist_card.dart';
import 'widgets/video_card.dart';

// Экран вида спорта - Вид спорта

class KindOfSportScreen extends StatelessWidget {
//  final String text;

  void _searchIconAction() {
    // Search some video function
  }

  KindOfSportScreen({
    Key key,
//    @required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 240;
    return Scaffold(
      appBar: AppBar(
        title: Text('Вид спорта'),
        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchIconAction,
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(14, 11, 38, 1),
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[

            // Карточка вида спорта в самом верху страницы
            HeaderKindOfSport(),

            TextSign(text:'Рекомендуем'),

            // Список рекомендуемых фильмов
            RecommendationFilmsList(),

            TextSign(text: 'Лучший плейлист'),

            // Карточка лучшего плейлиста
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: PlayListCard(),
            ),

            TextSign(text:'Другие плейлисты'),

            // Список для скроллинга - Другие плейлисты
            OtherPlaylistList(),

            TextSign(text:'Лучшее видео'),
            // Картока - Лучшее видео
            VideoCard(aspectRatio: 16/9,),

          ],
        ),
      ),
    );
  }
}

// Список рекомендуемых фильмов
class RecommendationFilmsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 200;
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
      height: cardHeigth,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[

          FilmCard(aspectRatio: 9/16),
          FilmCard(aspectRatio: 9/16),
          FilmCard(aspectRatio: 9/16),
          FilmCard(aspectRatio: 9/16),
          FilmCard(aspectRatio: 9/16),
        ],
      ),
    );
  }
}

// Список для скроллинга - Другие плейлисты
class OtherPlaylistList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 110;
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
      height: cardHeigth,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          PlayListCard(small: true,aspectRatio: 2/1,),
          PlayListCard(small: true,aspectRatio: 2/1,),
          PlayListCard(small: true,aspectRatio: 2/1,),
          PlayListCard(small: true,aspectRatio: 2/1,),
          PlayListCard(small: true,aspectRatio: 2/1,),
        ],
      ),
    );
  }
}

// Карточка для плейлистов
class OtherPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 110;
    return Card(
//      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      elevation: 0.0,
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
//          Navigator.push(context, MaterialPageRoute(
//            builder: (context) => KindOfSportScreen(),
//          ));
        },
        child: Container(
          width: screenWigth / 2,
          height: cardHeigth,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                width: screenWigth / 2,
                height: cardHeigth,
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
              ),
              Positioned(
                width: screenWigth / 2,
                height: cardHeigth,
                top: 0,
                left: 0,
                child: Container(
                  color: Color.fromRGBO(14, 11, 38, 0.4),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 15,
                child: Container(
                  width: screenWigth / 2,
                  alignment: Alignment.bottomLeft,
                  color: Colors.transparent,
                  child: Text(
                    "Плейлист",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
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

// Карточка для рекомендуемых фильмов
class RecommendationFilms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 200;
    return Card(
//      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      elevation: 0.0,
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
//          Navigator.push(context, MaterialPageRoute(
//            builder: (context) => KindOfSportScreen(),
//          ));
        },
        child: Container(
          
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  color: Color.fromRGBO(14, 11, 38, 0.4),
                ),
              ),
              Positioned(
                top: 0,
                right: 10,
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
              Positioned(
                bottom: 30,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Text(
                    "Фильм",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 20.0,
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

// Карточка с видео и для просмотра видео (используется во многих местах)

// Карточка вида спорта в самом верху страницы
class HeaderKindOfSport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 240;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: screenWigth,
          height: cardHeigth,
          decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  // 10% of the width, so there are ten blinds.
                  colors: [
                    const Color.fromRGBO(14, 11, 38, 1),
                    const Color.fromRGBO(14, 11, 38, 0)
                  ],
                  // whitish to gray
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
            )),
        Positioned(
          bottom: 5,
          child: Container(
            color: Colors.transparent,
            width: screenWigth,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    "Вид спорта",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Описание данного вида спорта",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KindOfSportStats(text:'1555', icon: Icons.thumb_up),
                    KindOfSportStats(text:'89', icon: Icons.local_movies),
                    KindOfSportStats(text:'21', icon: Icons.playlist_play)
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        textColor: Colors.black,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: 28,
                          width: screenWigth / 4,
                          alignment: Alignment.center,
//                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: const Text('Видео',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        textColor: Colors.black,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: 28,
                          width: screenWigth / 3,
                          alignment: Alignment.center,
//                                padding: const EdgeInsets.all(5.0),
                          child: const Text('Плейлисты',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        textColor: Colors.black,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: 28,
                          width: screenWigth / 3.5,
                          alignment: Alignment.center,
//                                padding: const EdgeInsets.all(5.0),
                          child: const Text('Фильмы',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TextSign extends StatelessWidget {
  final String text;
  TextSign({this.text});
  @override
  Widget build(BuildContext context) {
    return 
    Container(
              padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
              child: Text(
                text,//'Другие плейлисты',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
    );
  }
}

// Иконка + количество
class KindOfSportStats extends StatelessWidget {
  final String text;
  final IconData icon;

  KindOfSportStats({this.text, this.icon});

  @override
  
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
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
      ]
    );
      
  }
}