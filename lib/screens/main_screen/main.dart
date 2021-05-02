import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'account_screen/main.dart';
import 'browse_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final String? title;

  MainScreen({Key? key, this.title}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

final screens = [
  (Key key) => HomeScreen(
        navigatorKey: key,
      ),
  (Key key) => BrowseScreen(
        navigatorKey: key,
      ),
  (Key key) => AccountScreen(
        navigatorKey: key,
      ),
];

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin<MainScreen> {
  int _selectedIndex = 0;
  DateTime? _currentBackPressTime;
  List<GlobalKey<NavigatorState>>? _navigatorKeys;
  final double _navBarOffset = Indents.md;

  List<Widget>? _screens;

  @override
  void initState() {
    super.initState();

    _navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
        screens.length, (int index) => GlobalKey()).toList();
    _screens = screens.map<Widget>((e) {
      var idx = screens.indexOf(e);
      return e(_navigatorKeys![idx]);
    }).toList();
    if(!store.state.user!.isSubscribed)
      setState(() {
        _selectedIndex = 2;
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final NavigatorState? navigator =
            _navigatorKeys?[_selectedIndex].currentState;
        if (!navigator!.canPop()) {
          DateTime now = DateTime.now();
          if (_currentBackPressTime == null ||
              now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
            setState(() {
              _currentBackPressTime = now;
            });
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)?.translate('helper.exit_hint'),
                backgroundColor: Colors.black.withOpacity(0.5));
            return false;
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
            children: _screens!,
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
                }, (int idx) {
                  var navigator = _navigatorKeys![idx].currentState;
                  if (navigator!.canPop())
                    _navigatorKeys![idx].currentState?.popUntil((route) => !route.navigator!.canPop());
                }),
              ))
        ])),
      )),
    );
  }
}
