import 'dart:ffi';

import 'package:extreme/homePage.dart';
import 'package:extreme/settingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/painting.dart';

import 'accountPage.dart';
import 'browsePage.dart';
import 'newsPage.dart';

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
  int _selectedIndex = 0;
  List<Widget> widgets = [
    HomeScreen(),
    BrowseScreen(text:"Hello"),
    NewsScreen(text:"Hello"),
    AccountScreen(text:"Hello"),
  ];
  void _searchIconAction() {
    // Search some video function
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print(_selectedIndex);
    print(widgets[_selectedIndex]);

//    if (_selectedIndex == 1){
//      Navigator.push(context, MaterialPageRoute(
//        builder: (context) => BrowseScreen(text: "Текст",),
//      ));
//    }
//    if (_selectedIndex == 2){
//      Navigator.push(context, MaterialPageRoute(
//        builder: (context) => NewsScreen(text: "Текст",),
//      ));
//    }
//    if (_selectedIndex == 3){
//      Navigator.push(context, MaterialPageRoute(
//        builder: (context) => AccountScreen(text: "Текст",),
//      ));
//    }
  }

  ScrollController firstScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
        currentIndex: _selectedIndex,
        unselectedItemColor: Color.fromRGBO(182, 181, 189, 1),
        selectedLabelStyle: TextStyle(
          color: Color.fromRGBO(182, 181, 189, 1),
        ),
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            title: Text(
              'Browse',
              style: TextStyle(
//                color: Color.fromRGBO(182, 181, 189, 1),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text(
              'News',
              style: TextStyle(
//                color: Color.fromRGBO(182, 181, 189, 1),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text(
              'Account',
              style: TextStyle(
//                color: Color.fromRGBO(182, 181, 189, 1),
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

//class SecondScreen extends StatelessWidget {
//  final String text;
//
//  // receive data from the FirstScreen as a parameter
//  SecondScreen({Key key, @required this.text}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Second screen')),
//      body: Center(
//        child: Text(
//          text,
//          style: TextStyle(fontSize: 24),
//        ),
//      ),
//    );
//  }
//}