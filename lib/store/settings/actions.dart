import 'package:extreme/models/main.dart';

class SetSettings {
  final Culture? culture;
  final Currency? currency;

  SetSettings({this.culture, this.currency});

  @override
  String toString() {
    return 'SetSettings{culture: $culture, currency: $currency}';
  }
}

class SetSettingsFcmToken {
  final String? fcmToken;

  SetSettingsFcmToken({this.fcmToken});

  @override
  String toString() {
    return 'SetSettingsFcmToken{fcmToken: $fcmToken}';
  }
}