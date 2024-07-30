import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import '../../firebase_options.dart';
import 'notification/alert_notification.dart';

class LoadFirebase {
  static void initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FCMMess().handleFirebaseMess();
  }
}

class FCMMess {
  static final FCMMess _singleton = FCMMess._internal();
  FCMMess._internal();

  factory FCMMess() {
    return _singleton;
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void removeID() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    var map = message.data;

    print(map);

    if (map.containsKey('data')) {
      final dynamic data = map['data'];
    }

    if (map.containsKey('notification')) {
      final dynamic notification = map['notification'];
    }
  }

  void handleFirebaseMess() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp data: ${message.data}");
      SahaNotificationAlert.alertNotification(message);
    FlutterAppBadger.updateBadgeCount(int.tryParse(message.data['badge'])  ?? 0);  
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
     
        print("getInitialMessage data: ${message?.data}");
        SahaNotificationAlert.alertNotification(message ?? RemoteMessage());
        //FlutterAppBadger.updateBadgeCount(int.tryParse(message?.data['badge'])  ?? 0);  

    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage data: ${message.data}");
      print("onMessage data badge: ${message.notification?.apple?.badge ?? "nullllll"}");
      SahaNotificationAlert.alertNotification(message);
      
       FlutterAppBadger.updateBadgeCount(int.tryParse(message.data['badge'])  ?? 0);  
      
    });
    await initToken();
  }

  Future<void> initToken() async {
    try {
      await _firebaseMessaging.getToken().then((String? token) async {
        assert(token != null);
        print("Push Messaging token: $token");
        FCMToken().setToken(token);

        if (UserInfo().getToken() != null) {
          RepositoryManager.deviceTokenRepository.updateDeviceTokenUser(token);
        }
      });
    } catch (err) {
      print(err.toString());
    }
    return;
  }
}

class FCMToken {
  static final FCMToken _singleton = new FCMToken._internal();

  String? _token;

  String? get token => _token;

  factory FCMToken() {
    return _singleton;
  }

  FCMToken._internal();

  void setToken(String? code) {
    _token = code;
  }

  String? getToken() {
    return _token;
  }
}
