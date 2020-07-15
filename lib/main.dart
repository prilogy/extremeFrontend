import 'package:extreme/homePage.dart';
import 'package:extreme/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
//import 'package:flutter_svg/flutter_svg.dart';

import 'accountPage.dart';
import 'browsePage.dart';
import 'redux.dart';
import 'screens/news_screen.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

const List<String> assetNames = <String>['svg/home.svg', 'svg/nothing.svg'];

// Главный модуль

void main() {
  // TODO: implement get initialState from rest API
  final store = Store<Info>(infoReducer, initialState: Info(likesCount: 100));
  print(store.state.likesCount.toString()); // likesCount = 100
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Store<Info> store; // redux store

  MyApp({Key key, this.store});

  @override
  Widget build(BuildContext context) {
    print('MyApp builder: ' + store.state.likesCount.toString());
    return StoreProvider<Info>(
      store: store,
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: new TextTheme(
                subtitle1: TextStyle(fontWeight: FontWeight.w500),
                caption: TextStyle(color: Colors.white))),
        home: MyHomePage(title: 'Extreme', store: store),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Store<Info> store;
  final String title;

  MyHomePage({Key key, this.title, this.store}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Store<Info> store; // store is null (why?)

  // роутинг по bottomNavigationBar
  List<Widget> widgets = [
    HomeScreen(),
    BrowseScreen(),
    NewsScreen(),
    AccountScreen(text: "Hello"),
  ];

  // при нажатии на иконку в bottomNavigationBar устанавливаем индекс
  setSelectedIndex(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  ScrollController firstScroll = ScrollController();

  final double _navBarOffset = 7;

  @override
  Widget build(BuildContext context) {
    print('_MyHomePageState builder: ' +
        widget.store.state.likesCount.toString());
    return Scaffold(
        body: Container(
            //padding: EdgeInsets.all(12),
            child: Stack(children: <Widget>[
          widgets[_selectedIndex],
          Positioned(
            bottom: _navBarOffset,
            left: _navBarOffset,
            right: _navBarOffset,
            height: 54,
            child: Container(child: NavBar(_selectedIndex, setSelectedIndex),))
        ])),
        backgroundColor: Color.fromRGBO(21, 22, 43, 1));
  }
}
