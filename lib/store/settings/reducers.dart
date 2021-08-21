import 'package:extreme/models/main.dart';
import 'package:extreme/store/settings/model.dart';
import 'package:redux/redux.dart';
import 'actions.dart' as Actions;

final settingsReducer = combineReducers<Settings>([
  TypedReducer<Settings, Actions.SetSettings>(_setSettings),
  TypedReducer<Settings, Actions.SetSettingsFcmToken>(_setSettingsFcmToken)
]);

Settings _setSettings(Settings state, Actions.SetSettings action) {
  if (action.currency != null)
    state.currency = Currency.all.firstWhere((x) => x == action.currency);

  if (action.culture != null)
    state.culture = Culture.all.firstWhere((x) => x == action.culture);

  Settings.saveToLocalStorage(state);

  return state;
}

Settings _setSettingsFcmToken(
    Settings state, Actions.SetSettingsFcmToken action) {
  state.fcmToken = action.fcmToken;
  Settings.saveToLocalStorage(state);
  return state;
}
