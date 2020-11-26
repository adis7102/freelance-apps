import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String tokenFCM = '';

  Future init() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onMessage $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onMessage $message");
      },
//      onBackgroundMessage: (Map<String, dynamic> message) async {
//        print("onMessage $message");
//      },
    );

    _firebaseMessaging.getToken().then((String token) async {
      if(token != null){
        tokenFCM = token;
      }
      print("Token FCM: $tokenFCM");
    });
  }

  String getToken(){
    return tokenFCM;
  }
}
