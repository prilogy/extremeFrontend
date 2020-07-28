import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/screens/auth_screen/login_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget implements IWithNavigatorKey {

  Key navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (context) => MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}