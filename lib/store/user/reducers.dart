import 'package:extreme/models/main.dart';
import 'package:redux/redux.dart';
import 'actions.dart' as Actions;

final userReducer = combineReducers<User>([
  TypedReducer<User, Actions.SetUser>(_setUser),
  TypedReducer<User, Actions.ToggleFavorite>(_toggleFavorite)
]);

User _setUser(User user, Actions.SetUser action) {
  User.saveToLocalStorage(action.user);
  return action.user;
}

// #favorite
// редьюсер для экшена, тут самое некрасивое место
// из за дарта и архитекруты апи сделать лучше вряд ли получится
// просто на основе entityType делаем дело, для лайка будет похожее, только там 2 сущности
User _toggleFavorite(User user, Actions.ToggleFavorite action) {
  switch (action.userAction.entityType) {
    case UserAction.video:
      user.favoriteIds.videos = _processFavoriteIdByUserAction(
          user.favoriteIds.videos, action.userAction);
      break;
    case UserAction.movie:
      user.favoriteIds.movies = _processFavoriteIdByUserAction(
          user.favoriteIds.movies, action.userAction);
      break;
    case UserAction.playlist:
      user.favoriteIds.playlists = _processFavoriteIdByUserAction(
          user.favoriteIds.playlists, action.userAction);
      break;
    case UserAction.sport:
      user.favoriteIds.sports = _processFavoriteIdByUserAction(
          user.favoriteIds.sports, action.userAction);
      break;
  }

  User.saveToLocalStorage(user);

  return user;
}

// #favorite
// функция котоаря делает лапшу выше чуть меньше
List<int> _processFavoriteIdByUserAction(
    List<int> list, UserAction userAction) {
  if (userAction.status == true)
    list.add(userAction.id);
  else
    list.remove(userAction.id);
  return list;
}
