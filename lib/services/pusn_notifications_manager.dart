import 'package:extreme/main.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/models/push_notification_data.dart';
import 'package:extreme/screens/movie_view_screen.dart';
import 'package:extreme/screens/playlist_screen.dart';
import 'package:extreme/screens/sport_screen.dart';
import 'package:extreme/screens/video_view_screen.dart';
import 'package:extreme/services/api/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/thunks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

late PushNotificationsManager pushNotificationsManager;

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  FirebaseMessaging? firebaseMessaging;
  bool _initialized = false;

  static Future<void> init() async {
    pushNotificationsManager = PushNotificationsManager();
    await pushNotificationsManager.initialize();
  }

  Future<void> disconnect() async {
    _initialized = false;
  }

  Future<void> initialize() async {
    if (!_initialized) {
      await Firebase.initializeApp();
      firebaseMessaging = FirebaseMessaging.instance;
      // For iOS request permission first.
      await firebaseMessaging?.requestPermission(
          alert: true, badge: true, sound: true);
      firebaseMessaging?.onTokenRefresh.listen((newToken) async {
        await store.dispatch(Thunks.handleFcm(newToken));
      });

      // From terminated state
      var msg = await FirebaseMessaging.instance.getInitialMessage();
      if (msg != null) handleMessage(msg);
      // From background state
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
      FirebaseMessaging.onMessage.listen(handleMessage);

      var token = await firebaseMessaging?.getToken();
      await store.dispatch(Thunks.handleFcm(token));

      _initialized = true;
    }
  }

  /// Обработчик сообщений из приложения на фоне
  static void handleMessage(RemoteMessage message) async {
    var data = PushNotificationData.fromMap(message.data);
    print(data.openId);
    print(data.openType);

    if (data.openType == null && data.openId == null) return;

    if (data.openType == PushNotificationOpenType.sport)
      await handleOpen<Sport>(data.openId!, (e) => SportScreen(model: e));
    else if (data.openType == PushNotificationOpenType.playlist)
      await handleOpen<Playlist>(data.openId!, (e) => PlaylistScreen(model: e));
    else if (data.openType == PushNotificationOpenType.movie)
      await handleOpen<Movie>(data.openId!, (e) => MovieViewScreen(model: e));
    else if (data.openType == PushNotificationOpenType.video)
      await handleOpen<Video>(data.openId!, (e) => VideoViewScreen(model: e));
  }

  static Future handleOpen<T>(int id, Build<T> w) async {
    var e = await Entities.getById<T>(id);
    if(e == null) return;

    rootNavigator.currentState?.push(MaterialPageRoute(builder: (ctx) => w(e)));
  }
}

typedef Widget Build<T>(T);
