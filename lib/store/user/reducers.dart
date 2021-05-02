import 'package:extreme/helpers/enums.dart';
import 'package:extreme/models/main.dart';
import 'package:redux/redux.dart';
import 'actions.dart' as Actions;

final userReducer = combineReducers<User?>([
  TypedReducer<User?, Actions.SetUser>(_setUser),
  TypedReducer<User?, Actions.ToggleFavorite>(_toggleFavorite),
  TypedReducer<User?, Actions.ToggleLike>(_toggleLike)
]);

User? _setUser(User? user, Actions.SetUser action) {
  User.saveToLocalStorage(action.user);
  return action.user;
}


User? _toggleFavorite(User? user, Actions.ToggleFavorite action) {
  if(user == null) return user;

  switch (action.userAction.entityType) {
    case Entities.video:
      user.favoriteIds?.videos = _processFavoriteIdByUserAction(
          user.favoriteIds?.videos, action.userAction);
      break;
    case Entities.movie:
      user.favoriteIds?.movies = _processFavoriteIdByUserAction(
          user.favoriteIds?.movies, action.userAction);
      break;
    case Entities.playlist:
      user.favoriteIds?.playlists = _processFavoriteIdByUserAction(
          user.favoriteIds?.playlists, action.userAction);
      break;
    case Entities.sport:
      user.favoriteIds?.sports = _processFavoriteIdByUserAction(
          user.favoriteIds?.sports, action.userAction);
      break;
  }

  User.saveToLocalStorage(user);

  return user;
}

List<EntityIdItem>? _processFavoriteIdByUserAction(
    List<EntityIdItem>? list, UserAction userAction) {
  if (userAction.status == true)
    list?.add(userAction.entityIdItem!);
  else
    list?.remove(userAction.entityIdItem);
  return list;
}

User? _toggleLike(User? user, Actions.ToggleLike action) {
  if(user == null) return user;
  switch (action.userAction.entityType) {
    case Entities.video:
      user.likeIds?.videos =
          _processLikeIdByUserAction(user.likeIds?.videos, action.userAction);
      break;
    case Entities.movie:
      user.likeIds?.movies =
          _processLikeIdByUserAction(user.likeIds?.movies, action.userAction);
      break;
  }

  User.saveToLocalStorage(user);

  return user;
}

List<EntityIdItem>? _processLikeIdByUserAction(List<EntityIdItem>? list, UserAction userAction) {
  if (userAction.status == true)
    list?.add(userAction.entityIdItem!);
  else
    list?.remove(userAction.entityIdItem);
  return list;
}
