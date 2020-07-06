import 'package:extreme/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'accountPage.dart';
import 'browsePage.dart';
import 'newsPage.dart';

// Главный модуль

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
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Extreme'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  // роутинг по bottomNavigationBar
  List<Widget> widgets = [
    HomeScreen(),
    BrowseScreen(text: "Hello"),
    NewsScreen(text: "Hello"),
    AccountScreen(text: "Hello"),
  ];

  // при нажатии на иконку в bottomNavigationBar устанавливаем индекс
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                  ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text(
              'News',
              style: TextStyle(
                  ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text(
              'Account',
              style: TextStyle(
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
