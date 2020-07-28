import 'package:extreme/models/main.dart';
import 'package:redux/redux.dart';
import 'actions.dart' as Actions;

final userReducer = combineReducers<User>([
  TypedReducer<User, Actions.SetUser>(_setUser)
]);

User _setUser(User user, Actions.SetUser action) {
  return action.user;
}