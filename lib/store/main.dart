import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/store/settings/model.dart';
import 'package:extreme/store/settings/reducers.dart';
import 'package:extreme/store/user/reducers.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

class AppState {
  final Models.User user;
  final Settings settings;

  AppState({@required this.user, @required this.settings});

  AppState.initialState()
      : user = Models.User.fromLocalStorage(),
        settings = Settings.fromLocalStorage();

}

AppState appStateReducer(AppState state, action) {
  return AppState(
    user: userReducer(state.user, action),
    settings: settingsReducer(state.settings, action)
  );
}

final Store<AppState> store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initialState()
);