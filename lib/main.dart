import 'package:extreme/config/env.dart';
import 'package:extreme/router/router.dart';
import 'screens/main_screen/account_screen.dart';
import 'screens/main_screen/home_screen.dart';
import 'package:extreme/styles/app_theme.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
//import 'package:flutter_svg/flutter_svg.dart';

import 'redux.dart';

import './config/env.dart' as Env;
import './redux.dart' as Redux;
import 'package:flutter_redux/flutter_redux.dart';

// TODO: wtf is this?
const List<String> assetNames = <String>['svg/home.svg', 'svg/nothing.svg'];

void main() async {
  Env.Config = await EnvConfig.get("./.env");

  runApp(App(store: Redux.store));
}

class App extends StatelessWidget {
  final Store<Info> store; // redux store
  App({Key key, this.store});

  @override
  Widget build(BuildContext context) {
    // debug message for theme debug(still not working properly)
    print("myapp - " + Theme.of(context).backgroundColor.toString());
    return StoreProvider<Info>(
      store: store,
      child: MaterialApp(
        title: 'Flutter App',
        theme: AppTheme.dark,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
