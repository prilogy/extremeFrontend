import 'package:extreme/screens/auth_screen/main.dart';
import 'package:extreme/screens/main_screen/main.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/main':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case '/auth':
        return MaterialPageRoute(builder: (_) => AuthScreen());
    }
  }
}
