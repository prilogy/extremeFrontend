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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            iconSize: 50,
                            icon: Icon(
                                Icons.playlist_play,
                                color: Color.fromRGBO(182, 181, 189, 1)
                            ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          iconSize: 50,
                          icon: Icon(
                              Icons.videocam,
                              color: Color.fromRGBO(182, 181, 189, 1)
                          ),
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

                  ],
                ),
                Container(
                  color: Color.fromRGBO(14, 11, 38, 1),
//                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  height: 440,
                  child: GridView.count(
                  crossAxisCount: 2,
                    children: <Widget>[
                      _latestUpdatesCard(context, "Мотогонки"),
                      _latestUpdatesCard(context, "Спорткары"),
                      _latestUpdatesCard(context, "Мотогонки"),
                      _latestUpdatesCard(context, "Спорткары"),
                    ],
                ),
                ),
//                GridView.count(
//                  crossAxisCount: 2,
//                    children: <Widget>[
//
//                    ],
//                ),
              ],
          ),
      ),
    );
  }
}

Widget _latestUpdatesCard(BuildContext context, String _title) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      SizedBox(
        child: Card(
          elevation: 0.0,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  width: 200,
                  image: ExactAssetImage("extreme2.jpg"),
                ),
              ),
            ],
          ),
        ),
      ),

      new Positioned(
        width: 208,
        height: 100,
        top: 0,
        child: Container(
          color: Color.fromRGBO(14, 11, 38, 0.4),
        ),
      ),
      new Positioned(
        top: 0,
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
      new Positioned(
        top: 0,
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
      new Positioned(
        top: 32.5,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
          child: Text(
            _title,
            style: TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}
