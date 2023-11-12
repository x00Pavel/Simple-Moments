import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_moments/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'api_service/app_config/app_config.dart';
import 'api_service/push_notification_service/firebase_notifications.dart';
import 'dependency/get_it.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(devMode);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  PushNotificationService()
    ..createChannel()
    ..setNotifications();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const Index());
  });
}
