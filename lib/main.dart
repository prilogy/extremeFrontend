import 'package:extreme/config/env.dart' as Env;
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/router/main.dart';
import 'package:extreme/services/dio.dart' as Dio;
import 'package:extreme/services/localstorage.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/settings/actions.dart';
import 'package:extreme/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redux/redux.dart';

import './config/env.dart' as Env;
import 'package:flutter_redux/flutter_redux.dart';

final rootScaffold = GlobalKey<ScaffoldState>();

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
          supportedLocales: [
            Locale(Culture.en.key, ''),
            Locale(Culture.ru.key, '')
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          localeListResolutionCallback: (locales, supportedLocales) {
            if (store.state.settings?.culture != null)
              return Locale(store.state.settings.culture.key, '');
            for (var loc in locales) {
              for (var supp in supportedLocales) {
                if (supp.languageCode == loc.languageCode) {
                  var culture =
                      Culture.all.firstWhere((x) => x.key == supp.languageCode);
                  store.dispatch(SetSettings(
                      culture: culture,
                      currency: culture.key == 'en'
                          ? Currency.USD
                          : culture.key == 'ru' ? Currency.RUB : Currency.USD));
                  return supp;
                }
              }
            }
            return supportedLocales.first;
          },
          theme: AppTheme.dark,
          builder: (context, w) => Scaffold(
                key: rootScaffold,
                body: Navigator(
                  onGenerateRoute: RouteGenerator.generateRoute,
                  initialRoute: store.state.user == null ? '/auth' : '/main',
                ),
              )),
    );
  }
}
