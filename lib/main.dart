import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/painting.dart';

//import 'package:simple_slider/simple_slider.dart';
//import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Extreme'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;

//  final _imageUrls = [
//    "https://png.pngtree.com/thumb_back/fw800/back_pic/00/03/35/09561e11143119b.jpg",
//    "https://png.pngtree.com/thumb_back/fw800/back_pic/04/61/87/28586f2eec77c26.jpg",
//    "https://png.pngtree.com/thumb_back/fh260/back_pic/04/29/70/37583fdf6f4050d.jpg",
//    "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg"
//  ];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _searchIconAction() {
    // Search some video function
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ScrollController firstScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return new Scaffold(
      body: Container(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play,
                color: Color.fromRGBO(182, 181, 189, 1)),
            title: Text(
              'Browse',
              style: TextStyle(
                color: Color.fromRGBO(182, 181, 189, 1),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books,
                color: Color.fromRGBO(182, 181, 189, 1)),
            title: Text(
              'News',
              style: TextStyle(
                color: Color.fromRGBO(182, 181, 189, 1),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box,
                color: Color.fromRGBO(182, 181, 189, 1)),
            title: Text(
              'Account',
              style: TextStyle(
                color: Color.fromRGBO(182, 181, 189, 1),
              ),
            ),
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
//                  color: Colors.white,
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
//        Text(
//          'Рекомендуемые видео',
//          style: TextStyle(
//            color: Colors.white,
//          ),
//        ),
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