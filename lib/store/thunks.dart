import 'package:extreme/models/fcm_token_refresh_model.dart';
import 'package:extreme/services/api/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/settings/actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class Thunks {
  static ThunkAction<AppState> handleFcm(String? token) {
    return (Store<AppState> store) async {
      var currentToken = store.state.settings?.fcmToken;

      print('FCM TOKEN: ' + (currentToken ?? 'no token'));

      if (token == currentToken) return;

      var result = await User.fcm(FcmTokenRefreshModel(oldToken: currentToken, newToken: token));
      if (result == true) await store.dispatch(SetSettingsFcmToken(fcmToken: token));
    };
  }
}