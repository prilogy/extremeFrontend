import 'package:extreme/config/env.dart' as Env;
import 'package:extreme/router/main.dart';
import 'package:extreme/services/dio.dart' as Dio;
import 'package:extreme/services/localstorage.dart';
import 'package:extreme/store/main.dart';
import 'screens/main_screen/home_screen.dart';
import 'package:extreme/styles/app_theme.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
//import 'package:flutter_svg/flutter_svg.dart';

import 'store/info.dart';

import './config/env.dart' as Env;
import 'store/info.dart' as Redux;
import 'package:flutter_redux/flutter_redux.dart';


void main() async {
  await Env.init("./.env");
  Dio.init();
  await localStorage.ready;
  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<AppState> store;
  App({Key key, this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter App',
        theme: AppTheme.dark,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: store.state.user == null ? '/auth' : '/main',
      ),
    );
  }
}
