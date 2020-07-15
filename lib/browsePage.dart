import 'dart:ui';

import 'package:extreme/kindOfSport.dart';
import 'package:extreme/playList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
          children: <Widget>[
            KindCard(),
            KindCard(),
            KindCard()],
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
          decoration: BoxDecoration (
            gradient: RadialGradient(
                    colors: [
                      Color(0x5009042c),
                      Color(0xA209042c)
                      ], 
                    center: Alignment.center,
                    radius: 1,
                    stops: <double>[0, 1],
                    ),
          ),
            
          //color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[                
                    Row(
                      children: <Widget>[
                        PlayListStats(icon: Icons.thumb_up, text: '1555'),
                        PlayListStats(icon: Icons.local_movies, text: '89'),
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
                    "Краткое описание плейлиста",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .merge(new TextStyle(color: Colors.white)),
                    ),
                  ]
              ),
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
              
              // Positioned(
              //   width: screenWigth,
              //   height: cardHeigth,
              //   top: 0,
              //   left: 0,
              //   child: Container(
              //     decoration: BoxDecoration(
              //     gradient: RadialGradient(
              //       colors: [
              //         Color(0x2709042c),
              //         Color(0x8309042c)
              //         ], 
              //       center: Alignment.center,
              //       radius: 2,
              //       stops: <double>[0, 0.8],
              //       ),
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 0,
              //   bottom: 20,
              //   child: Container(
              //     color: Colors.transparent,
              //     padding: EdgeInsets.fromLTRB(0, 10, 5, 0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: <Widget>[
              //             PlayListStats(icon: Icons.thumb_up, text: '1555'),
              //             PlayListStats(icon: Icons.local_movies, text: '89'),
              //           ],
              //         ),
              //         Container(
              //           margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              //           color: Colors.transparent,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: <Widget>[
              //               Text(
              //                 "Название плейлиста",
              //                 style: TextStyle(
              //                   letterSpacing: 0.8,
              //                   fontWeight: FontWeight.w600,
              //                   fontFamily: 'Roboto',
              //                   fontSize: 20.0,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               Text(
              //                 "Краткое описание плейлиста",
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption
              //                     .merge(new TextStyle(color: Colors.white)),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   top: 0,
              //   right: 0,
              //   child: Container(
              //     color: Colors.transparent,
              //     child: IconButton(
              //       icon: Icon(
              //         Icons.favorite_border,
              //         color: Color.fromRGBO(182, 181, 189, 1),
              //       ),
              //       tooltip: 'Placeholder',
              //       onPressed: () {},
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class KindCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color(0x2709042c),
                      Color(0x8309042c)
                      ], 
                    center: Alignment.center,
                    radius: 2,
                    stops: <double>[0, 0.8],
                    ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text("Вид спорта",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.playlist_play),
                                Text(
                                  "10",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "10",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                                Icon(Icons.local_movies),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ),
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KindOfSportScreen(),
                      ));
                },
              ),
            )),
          ],
        ));
  }
}

/*
// Карточка с видом спорта
class KindCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final double cardHeight = 90;
    return Card(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('Card tapped.');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KindOfSportScreen(),
              ));
        },
        child: Container(
          width: screenWidth / 2 - 30,
          height: cardHeight,
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
                height: cardHeight,
                padding: EdgeInsets.all(5),


                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

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
