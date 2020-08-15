import 'package:extreme/models/main.dart' as Models;

class SetUser {
  final Models.User user;

  SetUser(this.user);

  @override
  String toString() {
    return 'User -> SetUser{user: $user}';
  }
}

class ToggleFavorite {
  final Models.UserAction userAction;

  ToggleFavorite(this.userAction);

  @override
  String toString() {
    return 'User -> ToggleFavorite{userAction: $userAction}';
  }
}
class ToggleLike {
  final Models.UserAction userAction;

  ToggleLike(this.userAction);

  @override
  String toString() {
    return 'User -> ToggleLike{userAction: $userAction}';
  }
}