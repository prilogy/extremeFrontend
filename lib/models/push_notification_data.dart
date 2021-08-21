class PushNotificationData {
  int? openId;
  PushNotificationOpenType? openType;

  PushNotificationData.fromMap(Map<String, dynamic> data) {
    openId = int.tryParse(data['open_id']);
    openType = openId == null ? null : m[data['open_id_type']];
  }
}

enum PushNotificationOpenType {
  sport,
  playlist,
  movie,
  video
}

Map<String, PushNotificationOpenType> m = {
  'sport': PushNotificationOpenType.sport,
  'playlist': PushNotificationOpenType.playlist,
  'movie': PushNotificationOpenType.movie,
  'video': PushNotificationOpenType.video,

};