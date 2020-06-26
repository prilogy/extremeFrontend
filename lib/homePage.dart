import 'dart:ffi';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomeScreen extends StatelessWidget {

  void _searchIconAction() {
    // Search some video function
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(14, 11, 38, 1),
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          new Stack(
            children: <Widget>[
              Container(
                //My container or any other widget
                color: Color.fromRGBO(14, 11, 38, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _carouselOfMainVideos(context),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                      child: Text(
                        'Интересные виды спорта',
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    _interestingVideo(context),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                      child: Text(
                        'Рекомендуемые видео',
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    _recommendedVideo(context),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                      child: Text(
                        'Последние обновления',
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    _latestUpdates(context),
                  ],
                ),
              ),
              new Positioned(
                //Place it at the top, and not use the entire screen
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  title: Text('Extreme'),
                  actions: <Widget>[
                    new IconButton(
                      icon: new Icon(Icons.search),
                      onPressed: _searchIconAction,
                    ),
                  ],
                  backgroundColor: Colors.transparent, //No more green
                  elevation: 0.0, //Shadow gone
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _carouselOfMainVideos(BuildContext context) {
  return SizedBox(
      height: 250.0,
      child: Carousel(
        images: [
//                    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
//                    NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
          ExactAssetImage("extreme2.jpg"),
          ExactAssetImage("extreme2.jpg"),
          ExactAssetImage("extreme2.jpg"),
          ExactAssetImage("extreme2.jpg"),
          ExactAssetImage("extreme2.jpg"),
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Color.fromRGBO(255, 255, 255, 0.7),
        indicatorBgPadding: 10.0,
        dotBgColor: Colors.purple.withOpacity(0.0),
        borderRadius: false,
        moveIndicatorFromBottom: 180.0,
        noRadiusForIndicator: true,
        overlayShadow: true,
        overlayShadowColors: Color.fromRGBO(14, 11, 38, 1),
        overlayShadowSize: 0.7,

      ));
}

Widget _interestingVideo(BuildContext context) {
  return Container(
    color: Color.fromRGBO(14, 11, 38, 1),
    margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
    height: 110,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        _interestingVideoCard(context, "Мотогонки"),
        _interestingVideoCard(context, "Спорткары"),
        _interestingVideoCard(context, "Мотогонки"),
        _interestingVideoCard(context, "Спорткары"),
        _interestingVideoCard(context, "Мотогонки"),
      ],
    ),
  );
}

Widget _recommendedVideo(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Card(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          'Формула 1. Россия',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        SizedBox(
          child: Card(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          'Формула 1. Италия',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        SizedBox(
          child: Card(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          'Формула 1. Абу-Даби',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget _latestUpdates(BuildContext context) {
  return Container(
    color: Color.fromRGBO(14, 11, 38, 1),
//                  color: Colors.white,
    margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
    height: 110,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        _latestUpdatesCard(context, "Мотогонки"),
        _latestUpdatesCard(context, "Спорткары"),
        _latestUpdatesCard(context, "Мотогонки"),
        _latestUpdatesCard(context, "Спорткары"),
        _latestUpdatesCard(context, "Мотогонки"),
      ],
    ),
  );
}

Widget _interestingVideoCard(BuildContext context, String _title) {
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
        height: 108,
        top: 0,
        child: Container(
          color: Color.fromRGBO(14, 11, 38, 0.53),
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
        height: 108,
        top: 0,
        child: Container(
          color: Color.fromRGBO(14, 11, 38, 0.4),
        ),
      ),
      new Positioned(
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
      new Positioned(
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

