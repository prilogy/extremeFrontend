import 'package:extreme/config/env.dart' as Env;
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/router/main.dart';
import 'package:extreme/services/dio.dart' as Dio;
import 'package:extreme/services/localstorage.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redux/redux.dart';

import './config/env.dart' as Env;
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
        title: 'ExtremeInsiders',
        supportedLocales: [Locale('en', ''), Locale('ru', '')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeListResolutionCallback: (locales, supportedLocales) {
          for (var loc in locales) {
            for (var supp in supportedLocales) {
              if (supp.languageCode == loc.languageCode) return supp;
            }
          }

          return supportedLocales.first;
        },
        theme: AppTheme.dark,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: store.state.user == null ? '/auth' : '/main',
      ),
    );
  }
}
