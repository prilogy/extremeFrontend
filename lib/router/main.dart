import 'package:extreme/screens/auth_screen/main.dart';
import 'package:extreme/screens/main_screen/main.dart';
import 'package:extreme/screens/search_screen.dart';
import 'package:extreme/screens/settings_screen.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/app_theme.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    var route = routes.firstWhere((x) => x.routeName == settings.name, orElse: () => null);

    if(route != null) {
      var pass = !route.requireAuthorization || (route.requireAuthorization && store.state.user != null);
      return MaterialPageRoute(builder: (_) => pass ? route.widget(args) : authRoute.widget(args));
    }
  }
}

final authRoute = RouteBuilder('/auth', (args) => AuthScreen(), false);

final routes = [
  authRoute,
  RouteBuilder('/main', (args) => MainScreen()),
  RouteBuilder('/settings', (args) => SettingsScreen()),
  RouteBuilder('/search', (args) => SearchScreen(query: args.toString(),)),
];

class RouteBuilder {
  final String routeName;
  final Widget Function(dynamic args) widget;
  final bool requireAuthorization;

  RouteBuilder(this.routeName, this.widget, [this.requireAuthorization=true]);
}