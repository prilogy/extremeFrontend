import 'package:extreme/config/env.dart';
import 'package:extreme/screens/account_screen.dart';
import 'screens/home_screen.dart';
import 'package:extreme/screens/browse_screen.dart';
import 'package:extreme/styles/app_theme.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
//import 'package:flutter_svg/flutter_svg.dart';

import 'accountPage.dart';
import 'helpers/interfaces.dart';
import 'redux.dart';
import 'screens/news_screen.dart';

import './config/env.dart' as Env;
import './redux.dart' as Redux;
import 'package:flutter_redux/flutter_redux.dart';

const List<String> assetNames = <String>['svg/home.svg', 'svg/nothing.svg'];

// Главный модуль

void main() async {
  Env.Config = await EnvConfig.get("./.env");

  runApp(MyApp(
    store: Redux.store
  ));
}

class MyApp extends StatelessWidget {
  final Store<Info> store; // redux store
  MyApp({Key key, this.store});

  @override
  Widget build(BuildContext context) {
    print("myapp - "+Theme.of(context).backgroundColor.toString());
    return StoreProvider<Info>(
      store: store,
      child: MaterialApp(
        title: 'Flutter App',
        theme: AppTheme.dark,
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
    AccountScreen(),
    OldAccountScreen(text: 'Hello',),
  ];

  // при нажатии на иконку в bottomNavigationBar устанавливаем индекс
  setSelectedIndex(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  ScrollController firstScroll = ScrollController();

  final double _navBarOffset = Indents.sm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // TODO: берется неправильная тема

    return Scaffold(
        appBar: widgets[_selectedIndex] is HasAppBar
            ? (widgets[_selectedIndex] as HasAppBar).appBar
            : null,

        body: Container(
            //padding: EdgeInsets.all(Indents.md),
            child: Stack(children: <Widget>[
          widgets[_selectedIndex],
          Positioned(
              bottom: _navBarOffset,
              left: _navBarOffset,
              right: _navBarOffset,
              height: NavBar.height,
              child: Container(
                child: NavBar(_selectedIndex, setSelectedIndex),
              ))
        ])));
  }
}
