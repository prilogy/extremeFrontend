import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/screens/main_screen/some_screen.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

import '../../accountPage.dart';
import '../../store/info.dart';
import 'account_screen.dart';
import 'browse_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final Store<Info> store;
  final String title;

  MainScreen({Key key, this.title, this.store}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin<MainScreen> {
  int _selectedIndex = 0;
  DateTime _currentBackPressTime;
  List<GlobalKey<NavigatorState>> _navigatorKeys;
  final double _navBarOffset = Indents.sm;

  List<Widget> screens = [
    HomeScreen(),
    BrowseScreen(),
    AccountScreen(),
    SomeScreen("smsmsm")
  ];

  @override
  void initState() {
    super.initState();

    _navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
        screens.length, (int index) => GlobalKey()).toList();
    screens = screens.map<Widget>((e) {
      var idx = screens.indexOf(e);
      if (e is IWithNavigatorKey) {
        (e as IWithNavigatorKey).navigatorKey = _navigatorKeys[idx];
      }
      return e;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context); // TODO: берется неправильная тема из контекста

    return WillPopScope(
      onWillPop: () async {
        final NavigatorState navigator =
            _navigatorKeys[_selectedIndex].currentState;
        if (!navigator.canPop()) {
          DateTime now = DateTime.now();
          if (_currentBackPressTime == null ||
              now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
            setState(() {
              _currentBackPressTime = now;
            });
            Fluttertoast.showToast(
                msg: "Для выхода из ExtremeInsiders повторите действие.",
                backgroundColor: Colors.black.withOpacity(0.5));
            return null;
          }
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }

        navigator.pop();
        return false;
      },
      child: Scaffold(
          body: SafeArea(
        top: false,
        child: Container(
            //padding: EdgeInsets.all(Indents.md),
            child: Stack(children: <Widget>[
          IndexedStack(
            index: _selectedIndex,
            children: screens,
          ),
          Positioned(
              bottom: _navBarOffset,
              left: _navBarOffset,
              right: _navBarOffset,
              height: NavBar.height,
              child: Container(
                child: NavBar(_selectedIndex, (int idx) {
                  setState(() {
                    _selectedIndex = idx;
                  });
                }),
              ))
        ])),
      )),
    );
  }
}
