import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BrowseScreen extends StatelessWidget {
  final String text;

  // receive data from the FirstScreen as a parameter
  BrowseScreen({Key key, @required this.text}) : super(key: key);

  void _searchIconAction() {
    // Search some video function
  }

  @override
  Widget build(BuildContext context) {
//    return Container(
//      color: Colors.indigo,
//    );
    return Scaffold(
      appBar: AppBar(
//        automaticallyImplyLeading: false,
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
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                        "Плейлист",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15.0,
                          color: Color.fromRGBO(182, 181, 189, 1),
                        ),
                      ),
                    ],
                  ),
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                      width: 165,
                      height: 100,
                      color: Colors.transparent,
                      child: Stack(
                          children: <Widget>[
                            Container(
                              width: 165,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: ExactAssetImage("extreme2.jpg"),
                                ),
                              ),
                            ),
                            Positioned(
                              width: 165,
                              height: 100,
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
                                      icon: Icon(
                                          Icons.local_movies,
                                          color: Color.fromRGBO(182, 181, 189, 1)
                                      ),
                                      tooltip: 'Placeholder',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                alignment: Alignment.center,
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
                ),
                Card(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                      width: 165,
                      height: 100,
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 165,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: ExactAssetImage("extreme2.jpg"),
                              ),
                            ),
                          ),
                          Positioned(
                            width: 165,
                            height: 100,
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
                                    icon: Icon(
                                        Icons.local_movies,
                                        color: Color.fromRGBO(182, 181, 189, 1)
                                    ),
                                    tooltip: 'Placeholder',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              alignment: Alignment.center,
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                      width: 165,
                      height: 100,
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 165,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: ExactAssetImage("extreme2.jpg"),
                              ),
                            ),
                          ),
                          Positioned(
                            width: 165,
                            height: 100,
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
                                    icon: Icon(
                                        Icons.local_movies,
                                        color: Color.fromRGBO(182, 181, 189, 1)
                                    ),
                                    tooltip: 'Placeholder',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              alignment: Alignment.center,
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
                ),
                Card(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                      width: 165,
                      height: 100,
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 165,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: ExactAssetImage("extreme2.jpg"),
                              ),
                            ),
                          ),
                          Positioned(
                            width: 165,
                            height: 100,
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
                                    icon: Icon(
                                        Icons.local_movies,
                                        color: Color.fromRGBO(182, 181, 189, 1)
                                    ),
                                    tooltip: 'Placeholder',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              alignment: Alignment.center,
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                      width: 165,
                      height: 100,
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 165,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: ExactAssetImage("extreme2.jpg"),
                              ),
                            ),
                          ),
                          Positioned(
                            width: 165,
                            height: 100,
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
                                    icon: Icon(
                                        Icons.local_movies,
                                        color: Color.fromRGBO(182, 181, 189, 1)
                                    ),
                                    tooltip: 'Placeholder',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              alignment: Alignment.center,
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
                ),
                Card(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                      width: 165,
                      height: 100,
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 165,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: ExactAssetImage("extreme2.jpg"),
                              ),
                            ),
                          ),
                          Positioned(
                            width: 165,
                            height: 100,
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
                                    icon: Icon(
                                        Icons.local_movies,
                                        color: Color.fromRGBO(182, 181, 189, 1)
                                    ),
                                    tooltip: 'Placeholder',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              alignment: Alignment.center,
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
                ),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}


