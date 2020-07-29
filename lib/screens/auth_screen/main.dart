import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/screens/auth_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthScreen extends StatefulWidget{
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Key navigatorKey = GlobalKey<NavigatorState>();

  DateTime _currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final NavigatorState navigator = (navigatorKey as GlobalKey<NavigatorState>).currentState;
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
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (context) =>
            MaterialPageRoute(builder: (context) => LoginScreen()),
      ),
    );
  }
}