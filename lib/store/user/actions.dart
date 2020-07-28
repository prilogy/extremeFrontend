import 'package:extreme/models/main.dart' as Models;

class SetUser {
  final Models.User user;

  SetUser(this.user);

  @override
  String toString() {
    return 'SetUser{user: $user}';
  }
}